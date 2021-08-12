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
#  dni                  :string
#  email                :string
#  firstname            :string
#  is_insured           :boolean
#  last_name            :string
#  legal_representative :string
#  main                 :boolean
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
#  index_customers_on_coverage            (coverage)
#  index_customers_on_coverage_reference  (coverage_reference)
#  index_customers_on_customer_code       (customer_code)
#  index_customers_on_dni                 (dni)
#  index_customers_on_email               (email)
#  index_customers_on_parent_id           (parent_id)
#  index_customers_on_plan_id             (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => customers.id)
#  fk_rails_...  (plan_id => plans.id)
#
class Customer < ApplicationRecord
  belongs_to :parent, class_name: 'Customer', foreign_key: 'parent_id', optional: true
  has_many :childs, class_name: 'Customer', foreign_key: 'parent_id', dependent: :destroy
  has_one :agreement, dependent: :destroy
  has_many :customer_diseases, dependent: :destroy
  has_many :diseases, through: :customer_diseases
  has_many :attachments,  as: :fileable

  belongs_to :plan, optional: true

  has_one_attached :files

  enum sex: { femenino: 0, masculino: 1 }

  attr_accessor :diagnosis, :id_attachment

  after_create :set_customer_code

  def full_name
    [firstname, second_name, last_name].compact.join(' ')
  end

  def set_customer_code
    return if main?

    "00#{parent.childs.length}"
  end
end
