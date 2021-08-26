# frozen_string_literal: true

class AgreementForm < BaseForm
  attr_reader :customer, :step, :user

  attr_writer :agreement_number,
              :amount,
              :diagnosis,
              :payment_method,
              :signed_date,
              :customer_id,
              :user_id

  def initialize(args: {}, customer: nil, step: nil, user: nil)
    super(args)
    @customer = customer
    @step = step
    @user = user
    @agreement = @customer.agreement || @customer.build_agreement(user_id: @user.id)
    @models = [@agreement]
    @new_record = @agreement.new_record?
  end

  def before_save
    set_initial_data
    set_agreement_data
    set_contract_number
  end

  def after_save
    @agreement.to_pending!
  end

  private

  def set_contract_number
    return unless @new_record

    @agreement.agreement_number = "SIP-#{@user.agent_code}-#{@user.agreements.count}"
  end

  def set_initial_data
    return unless @new_record

    @agreement.signed_date = Date.today
  end

  def set_agreement_data
    @agreement.amount = calculate_amount
  end

  def calculate_amount
    amount = @customer.is_insured ? @customer.plan.payment_fee.to_f : 0
    @customer.childs.each do |child|
      amount += child.plan.payment_fee.to_f
    end
    amount
  end
end
