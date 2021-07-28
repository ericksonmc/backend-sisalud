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
    @agreement = customer.agreement || @customer.build_agreement(user_id: @user.id)
    @models = [@agreement]
  end

  private

  def set_agreement_data
    return if @step != 'step_3'

    @agreement.amount = calculate_amount
  end

  def calculate_amount
    0
  end
end
