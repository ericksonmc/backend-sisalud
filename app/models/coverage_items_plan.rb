# == Schema Information
#
# Table name: coverage_items_plans
#
#  id               :bigint           not null, primary key
#  coverage         :integer
#  waiting_period   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  coverage_item_id :bigint           not null
#  plan_id          :bigint           not null
#
# Indexes
#
#  index_coverage_items_plans_on_coverage_item_id  (coverage_item_id)
#  index_coverage_items_plans_on_plan_id           (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (coverage_item_id => coverage_items.id)
#  fk_rails_...  (plan_id => plans.id)
#
class CoverageItemsPlan < ApplicationRecord
  belongs_to :plan
  belongs_to :coverage_item
end
