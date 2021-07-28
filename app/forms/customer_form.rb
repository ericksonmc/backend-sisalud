# frozen_string_literal: true

class CustomerForm < BaseForm
  attr_reader :args, :customer, :step, :user

  attr_writer :activity,
              :address,
              :age,
              :birthday,
              :coverage,
              :coverage_reference,
              :customer_code,
              :diagnosis,
              :dni,
              :email,
              :firstname,
              :is_insured,
              :last_name,
              :legal_representative,
              :main,
              :parent_id,
              :phone,
              :plan_id,
              :second_name,
              :secondary_phone,
              :sex,
              :size

  def initialize(args: {}, customer: nil, step: nil, user: nil)
    super(args)
    @args = args
    @customer = customer || Customer.new(args)
    @step = step
    @user = user
    @models = [@customer]
  end

  def after_save
    set_customer_code
    save_agreement
  end

  def before_save
    set_main
    set_insurance_data
  end

  private

  def set_insurance_data
    return unless @customer.plan_id.present?

    @customer.coverage_reference = @customer.plan.coverage
    @customer.coverage = amount_coverage
  end

  def amount_coverage
    return @customer.coverage if @customer.coverage.present?

    0
  end

  def save_agreement
    return unless @customer.main

    agreement.save!
  rescue StandardError => e
    Rails.logger.info do
      'Error while creating the agreement for customer.'\
        "Customer Email: #{@customer&.email}. Error message: #{e.message}"
    end
  end

  def set_main
    return if @customer.parent_id.present?

    @customer.main = true
  end

  def set_customer_code
    return if @customer.main

    "00#{parent.childs.length}"
  end

  def agreement
    @agreement ||= AgreementForm.new(customer: @customer, step: @step, user: @user)
    # @agreement ||= @customer.build_agreement({ step: @step, user_id: @user.id })
  end
end
