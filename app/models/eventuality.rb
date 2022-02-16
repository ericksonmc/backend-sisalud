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
  has_many :eventuality_expense_manuals, dependent: :destroy

  accepts_nested_attributes_for :eventuality_expenses
  accepts_nested_attributes_for :eventuality_expense_manuals

  enum event_type: { emergency: 0, medical_consultation: 1, specialized_medical_consultation: 2 }

  scope :emergencies, -> { where(event_type: 'emergency') }

  default_scope { agreement.nil? }

  before_destroy :revert_amount

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
      transitions from: [:pending], to: :cancelled
      after { update_coverage }
    end

    event :reopen do
      transitions from: [:closed], to: :reopened
    end

    event :close_again do
      transitions from: :reopened, to: :closed
      # after { update_amount }
    end
  end

  def invoice_url_image
    return if invoice_image.blank?

    rails_blob_path(invoice_image, disposition: 'attachment', only_path: true)
  end

  def update_coverage
    return if date.to_i > Time.now.to_i

    customer.update(coverage: customer.coverage + calculate_total)
    self.update(amount: calculate_total)
  end

  def revert_amount
    customer.update(coverage: customer.coverage - amount) if closed?
  end

  def calculate_total
    expenses = eventuality_expenses.where(charged: false)
                                   .inject(0) { |sum, item| sum + item.amount }

    manual_expenses = eventuality_expense_manuals&.where(charged: false)
                                                 &.inject(0) { |sum, item| sum + item.amount }

    expenses + manual_expenses
  end

  def set_charded_expenses
    eventuality_expenses.update_all(charged: true)
    eventuality_expense_manuals.update_all(charged: true)
  end
end
