# frozen_string_literal: true

# == Schema Information
#
# Table name: agreements
#
#  id               :bigint           not null, primary key
#  aasm_state       :string
#  agreement_number :string
#  amount           :float
#  diagnosis        :jsonb
#  payment_method   :integer
#  signed_date      :date
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
  include AASM
  belongs_to :customer
  belongs_to :user

  aasm do
    state :active, initial: true
    state :pending
    state :suspended
    state :rejected
    state :audit
    state :close

    event :to_pending do
      transitions from: :active, to: :pending, guard: :ready_for_pending?
      after { send_pending_review_email }
    end
  end

  def ready_for_pending?
    adult_over_sixty? && it_has_less_two_beneficiaries?
  end

  def adult_over_sixty?
    adult = contract_members.select { |member| member[:age] > 60 }

    adult.present?
  end

  def it_has_less_two_beneficiaries?
    contract_members.count < 3
  end

  def contract_members
    [customer].concat customer.childs
  end

  def status
    I18n.t("agreements.status.#{aasm_state}")
  end

  private

  def send_pending_review_email
    true
    return
    NotificationsMailer.pending_review(agreement: self).deliver_now
  end
end
