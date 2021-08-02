# frozen_string_literal: true

# == Schema Information
#
# Table name: agreements
#
#  id               :bigint           not null, primary key
#  agreement_number :string
#  amount           :float
#  diagnosis        :jsonb
#  payment_method   :integer
#  signed_date      :date
#  status           :integer          default("in_progress")
#  step             :string
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

  enum payment_method: { fc_cash: 0, fc_transfer: 1, lc_transfer: 2, lc_cash: 3 }
  enum status: { active: 0, suspended: 1, audit: 2, close: 3 }

  def contract_members
    [customer].concat customer.childs
  end
end
