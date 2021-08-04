# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id             :bigint           not null, primary key
#  age_limit      :integer
#  coverage       :float
#  coverage_items :jsonb
#  payment_fee    :float
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :bigint           not null
#
# Indexes
#
#  index_plans_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Plan < ApplicationRecord
  belongs_to :product
end
