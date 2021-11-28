# == Schema Information
#
# Table name: eventualities
#
#  id           :bigint           not null, primary key
#  aasm_state   :string
#  amount       :float
#  date         :datetime
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
  audited
  include AASM
  
  belongs_to :agreement
  belongs_to :customer

  has_many :eventuality_expenses, dependent: :destroy

  accepts_nested_attributes_for :eventuality_expenses

  enum event_type: { emergency: 0, medical_consultation: 1, specialized_medical_consultation: 2 }

  has_one_attached :invoice_image

  aasm do
    state :pending, initial: true
    state :closed
    state :cancelled

    event :close do
      transitions from: [:pending, :reject], to: :closed
    end

    event :cancel do
      transitions from: :pending, to: :cancelled
    end
  end
end
