# == Schema Information
#
# Table name: eventuality_expenses
#
#  id             :bigint           not null, primary key
#  amount         :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  eventuality_id :bigint           not null
#  scale_id       :bigint           not null
#
# Indexes
#
#  index_eventuality_expenses_on_eventuality_id  (eventuality_id)
#  index_eventuality_expenses_on_scale_id        (scale_id)
#
# Foreign Keys
#
#  fk_rails_...  (eventuality_id => eventualities.id)
#  fk_rails_...  (scale_id => scales.id)
#
class EventualityExpense < ApplicationRecord
  belongs_to :eventuality
  belongs_to :scale
end
