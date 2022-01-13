# == Schema Information
#
# Table name: eventuality_expense_manuals
#
#  id             :bigint           not null, primary key
#  amount         :float
#  charged        :boolean          default(FALSE)
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  eventuality_id :bigint           not null
#
# Indexes
#
#  index_eventuality_expense_manuals_on_eventuality_id  (eventuality_id)
#
# Foreign Keys
#
#  fk_rails_...  (eventuality_id => eventualities.id)
#
class EventualityExpenseManual < ApplicationRecord
  belongs_to :eventuality

  before_save :downcase_fields

  def downcase_fields
    title.downcase
  end
end
