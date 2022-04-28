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
#  insurance_period :string
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
  audited
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

    event :to_suspended do
      transitions from: [:active, :rejected, :audit, :close, :inactive, :pending], to: :suspended
    end

    event :reject do
      transitions from: [:active, :suspended, :audit, :close, :inactive, :pending], to: :rejected
    end

    event :audit do
      transitions from: [:active, :suspended, :rejected, :close, :inactive, :pending], to: :audit
    end

    event :close do
      transitions from: [:active, :suspended, :rejected, :audit, :inactive, :pending], to: :close
    end

    event :activate do
      transitions from: [:suspended, :rejected, :audit, :close, :inactive, :pending],
                  to: :active, guard: :valid_to_authorize?
    end

    event :inactive do
      transitions from: [:active, :suspended, :rejected, :audit, :close, :pending], to: :inactive
    end

    event :to_destroy do
      transitions from: [:active, :suspended, :rejected, :audit, :close, :inactive, :pending], to: :deleted
      after { delete_agreement }
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

  def clientes_and_insureds
    clients = 1 + customer.childs.length
    insureds = customer.plan.present? ? 1 : 0

    customer.childs.each do |c|
      insureds += 1 if c.plan.present?
    end

    [clients, insureds]
  end

  def agreement_plans
    customers = []
    customers << customer if customer.is_insured?
    customers.concat customer.childs.where(is_insured: true)
    plans = customers.each_with_object(Hash.new(0)) { |h1, h2| h2[h1[:plan_id]] += 1 }
    plans.transform_keys { |key| Plan.find(key.to_i).title }
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
    customer = self.customer
    customer.update({ deleted_at: Time.now })
    customer.childs&.update_all({ deleted_at: Time.now })
  end
end
