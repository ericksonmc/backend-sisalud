# frozen_string_literal: true

class AgreementForm < BaseForm
  attr_reader :customer, :user

  attr_writer :agreement_number,
              :amount,
              :diagnosis,
              :payment_method,
              :signed_date,
              :customer_id,
              :user_id

  def initialize(args: {}, customer: nil, user: nil, signed_date: nil)
    super(args)
    @customer = customer
    @user = user
    @signed_date = signed_date
    @agreement = @customer.agreement || @customer.build_agreement(user_id: @user.id)
    @models = [@agreement]
    @new_record = @agreement.new_record?
  end

  def before_save
    set_agreement_data
    set_contract_number
  end

  def after_save
    @agreement.to_pending!
  end

  private

  def set_contract_number
    return unless @new_record

    agreements_counts = @user.agreements.count + 1
    @agreement.agreement_number = "SIP-#{@user.agent_code}-#{agreements_counts.to_s.rjust(3, '0')}"
  end

  def set_agreement_data
    @agreement.amount = calculate_amount
    return unless @new_record

    @agreement.signed_date = @signed_date.present? ? @signed_date : Date.today
  end

  def calculate_amount
    amount = @customer.is_insured ? @customer.plan.payment_fee.to_f : 0
    @customer.childs.each do |child|
      amount += child.plan.payment_fee.to_f
    end
    amount
  end
end
