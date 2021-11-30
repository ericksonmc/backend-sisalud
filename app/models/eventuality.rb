# == Schema Information
#
# Table name: eventualities
#
#  id           :bigint           not null, primary key
#  aasm_state   :string
#  amount       :float
#  date         :date
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
  include Rails.application.routes.url_helpers
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
    state :reopened

    event :close do
      transitions from: [:pending], to: :closed
    end

    event :cancel do
      transitions from: [:pending, :reopened], to: :cancelled
      after { update_coverage }
    end

    event :reopen do
      transitions from: [:cancelled, :closed], to: :reopened
    end

    event :close_again do
      transitions from: :reopened, to: :close
      # after { update_amount }
    end
  end

  def invoice_url_image
    return nil if invoice_image.blank?

    rails_blob_path(invoice_image, disposition: 'attachment', only_path: true)
  end

  def update_coverage
    return if date.to_i > Time.now.to_i

    customer.update(coverage: customer.coverage + calculate_total)
    self.update(amount: calculate_total)
  end

  def calculate_total
    eventuality_expenses.inject(0) { |sum, item| sum + item.amount }
  end
end
