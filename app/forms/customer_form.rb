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

  # validates :firstname,
  #           :last_name,
  #           :second_name,
  #           :email, presence: true

  def initialize(args: {}, customer: nil, step: nil, user: nil)
    super(args)
    @args = args
    @customer = customer || Customer.new(args)
    @step = step
    @user = user
    @models = [@customer]
  end

  def model_name
    Customer.model_name
  end

  def after_save
    set_customer_code
    # init_agreement
  end

  def before_save
    set_main
  end

  def set_customer_code
    return if @customer.main

    "00#{parent.childs.length}"
  end

  def init_agreement
    return unless @customer.main

    agreement.save!
  end

  def set_main
    return if @customer.parent_id.present?

    @customer.main = true
  end

  def agreement
    @agreement ||= @customer.build_agreement({ step: 'step_1', user_id: @user.id })
  end
end
