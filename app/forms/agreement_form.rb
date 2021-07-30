# frozen_string_literal: true

class AgreementForm < BaseForm
  attr_reader :customer, :step, :user

  attr_writer :agreement_number,
              :amount,
              :diagnosis,
              :payment_method,
              :signed_date,
              :status,
              :customer_id,
              :user_id

  def initialize(args: {}, customer: nil, step: nil, user: nil, existing_agreement: {})
    super(args)
    @customer = customer
    @existing_agreement = existing_agreement
    @step = step
    @user = user
    @agreement = @customer.agreement || @customer.build_agreement(user_id: @user.id)
    @models = [@agreement]
  end

  def before_save
    set_step
    set_agreement_data
  end

  private

  def set_step
    @agreement.step = @step
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
