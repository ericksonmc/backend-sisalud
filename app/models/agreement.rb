# frozen_string_literal: true

# == Schema Information
#
# Table name: agreements
#
#  id               :bigint           not null, primary key
#  aasm_state       :string
#  agreement_number :string
#  amount           :float
#  deleted_at       :datetime
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
#  index_agreements_on_deleted_at        (deleted_at)
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

  default_scope { where(deleted_at: nil) }

  aasm do
    state :active, initial: true
    state :pending
    state :suspended
    state :rejected
    state :audit
    state :close
    state :inactive
    state :deleted

    event :to_pending do
      transitions from: :active, to: :pending, guard: :ready_for_pending?
      after { send_pending_review_email }
    end

    event :activate do
      transitions from: [:pending, :inactive, :deleted], to: :active, guard: :valid_to_authorize?
    end

    event :inactive do
      transitions from: [:active, :suspended, :rejected, :audit, :close], to: :inactive
    end

    event :to_destroy do
      transitions from: [:active, :suspended, :rejected, :audit, :close, :inactive], to: :deleted
      after { delete_agreement }
    end

    event :to_suspended do
      transitions from: [:active, :rejected, :audit, :close, :inactive], to: :suspended
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
    NotificationsMailer.pending_review(agreement: self).deliver_now
  end

  def valid_to_authorize?
    true
  end

  def delete_agreement
    self.update({ deleted_at: Time.now })
  end
end
