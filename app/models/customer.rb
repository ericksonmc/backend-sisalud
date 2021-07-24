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
#  diagnosis            :jsonb
#  dni                  :string
#  email                :string
#  firstname            :string
#  is_insured?          :boolean
#  last_name            :string
#  legal_representative :string
#  main                 :boolean
#  phone                :string
#  second_name          :string
#  secondary_phone      :string
#  sex                  :integer
#  size                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  parent_id            :bigint
#  plan_id              :bigint           not null
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
  belongs_to :parent, class_name: 'Customer', foreign_key: 'parent_id'
  has_many :childs, class_name: 'Customer', foreign_key: 'parent_id'

  validates :first_name,
            :last_name,
            :scond_name,
            :address,
            :phone, presence: true
  validates :dni, uniqueness: { case_sensitive: false }

  validates :size,
            :secondary_phone,
            :second_name,
            :phone,
            :legal_representative,
            :last_name,
            :firstname,
            :email,
            :dni,
            :activity,
            string: true

  validates :coverage, :coverage_reference, float: true

  after_create :set_customer_code

  def full_name
    [:first_name, :second_name, :last_name].compact.join(' ')
  end

  def set_customer_code
    return if main

    "00#{parent.childs.length}"
  end
end
