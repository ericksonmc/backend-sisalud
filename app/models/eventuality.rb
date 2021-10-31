# == Schema Information
#
# Table name: eventualities
#
#  id           :bigint           not null, primary key
#  aasm_state   :string
#  amount       :float
#  event_type   :integer
#  observations :string
#  password     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  agreement_id :bigint           not null
#  customer_id  :bigint           not null
#
# Indexes
#
#  index_eventualities_on_agreement_id  (agreement_id)
#  index_eventualities_on_customer_id   (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (agreement_id => agreements.id)
#  fk_rails_...  (customer_id => customers.id)
#
class Eventuality < ApplicationRecord
  include AASM
  belongs_to :agreement
  belongs_to :customer

  enum event_type: { emergency: 0, medical_consultation: 1, specialized_medical_consultation: 2 }

  aasm do
    state :pending, initial: true
    state :close
    state :cancelled

    event :rejected do
      transitions from: :pending, to: :reject
    end

    event :closed do
      transitions from: [:pending, :reject], to: :close
    end

    event :cancelled do
      transitions from: :pending, to: :cancelled
    end
  end
end
