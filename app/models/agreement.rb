# == Schema Information
#
# Table name: agreements
#
#  id               :bigint           not null, primary key
#  agreement_number :string
#  amount           :float
#  payment_method   :integer
#  signed_date      :date
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_agreements_on_agreement_number  (agreement_number)
#  index_agreements_on_customer_id       (customer_id)
#  index_agreements_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
class Agreement < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  enum payment_method: { fc_cash: 0, fc_transfer:1, lc_transfer: 2, lc_cash: 3 }
  enum status: { in_progress: 0, created: 1, suspended: 2, audit: 3, close: 4 }
end
