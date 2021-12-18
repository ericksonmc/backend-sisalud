# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id                   :bigint           not null, primary key
#  activity             :string
#  address              :jsonb
#  age                  :integer
#  birthday             :date
#  coverage             :float
#  coverage_reference   :float
#  customer_code        :string
#  deleted_at           :datetime
#  dni                  :string
#  email                :string
#  firstname            :string
#  is_insured           :boolean
#  last_name            :string
#  legal_representative :string
#  main                 :boolean
#  payment_fee          :float
#  phone                :string
#  second_name          :string
#  secondary_phone      :string
#  sex                  :integer
#  size                 :string
#  weight               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  parent_id            :bigint
#  plan_id              :bigint
#
# Indexes
#
#  index_customers_on_deleted_at  (deleted_at)
#  index_customers_on_dni         (dni)
#  index_customers_on_email       (email)
#  index_customers_on_parent_id   (parent_id)
#  index_customers_on_plan_id     (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => customers.id)
#  fk_rails_...  (plan_id => plans.id)
#
class Customer < ApplicationRecord
  attr_accessor :diagnosis, :id_attachment

  belongs_to :parent, class_name: 'Customer', foreign_key: 'parent_id', optional: true
  belongs_to :plan, optional: true

  has_many :childs, class_name: 'Customer', foreign_key: 'parent_id', dependent: :destroy
  has_many :customer_diseases, dependent: :destroy
  has_many :diseases, through: :customer_diseases, dependent: :destroy
  has_many :eventualities, dependent: :destroy

  has_one :agreement, dependent: :destroy
  has_one :attachment, as: :fileable, dependent: :destroy

  has_one_attached :files

  enum sex: { femenino: 0, masculino: 1 }

  default_scope { where(deleted_at: nil) }

  after_create :set_customer_code

  def full_name
    [firstname, second_name, last_name].compact.join(' ')
  end

  def set_customer_code
    return if main?

    "00#{parent.childs.length}"
  end

  def holder?
    parent_id.blank?
  end

  def act_agreement
    return agreement if holder?

    parent.agreement
  end

  def update_coverage(total)
    update(coverage: coverage.to_f + total.to_f)
  end

  def act_events
    eventualities.where(created_at: init_agreement..end_agreement)
  end

  def init_agreement
    act_agreement.insurance_period.split('/').first.to_date.beginning_of_day
  end

  def end_agreement
    act_agreement.insurance_period.split('/').last.to_date.end_of_day
  end
end
