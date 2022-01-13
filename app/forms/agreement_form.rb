# frozen_string_literal: true

class AgreementForm < BaseForm
  attr_reader :args, :customer, :user

  attr_accessor :state_change

  attr_writer :agreement_number,
              :amount,
              :diagnosis,
              :payment_method,
              :signed_date,
              :customer_id,
              :user_id

  def initialize(args: {}, customer: nil, user: nil, signed_date: nil, user_id: nil,
                 state_change: nil)
    super(args)
    @args = args
    @customer = customer
    @user = user || User.find(user_id)
    @signed_date = signed_date
    @agreement = @customer.agreement || @customer.build_agreement(user_id: @user.id)
    @models = [@agreement]
    @new_record = @agreement.new_record?
    @state_change = state_change
  end

  def before_save
    set_agreement_data
    set_contract_number
    set_insurance_period
  end

  def after_save
    check_is_active_or_pending
    update_state if state_change.present?
  end

  def before_validation
    assign_attributes_to_agreement
  end

  private

  def assign_attributes_to_agreement
    attributes = args.tap do |args|
      args[:id] = @agreement.id
    end

    @agreement.assign_attributes(attributes)
  end

  def update_state
    case state_change
    when 'active'
      @agreement.activate!
    when 'inactive'
      @agreement.inactive!
    when 'suspended'
      @agreement.to_suspended!
    when 'rejected' || 'reject'
      @agreement.reject!
    when 'audit'
      @agreement.audit!
    when 'close'
      @agreement.close!
    end
  end

  def check_is_active_or_pending
    return unless @new_record

    return unless adult_over_sixty?

    @agreement.to_pending!
  end

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

  def set_insurance_period
    return unless @new_record

    @agreement.insurance_period = "#{@agreement.signed_date}/#{@agreement.signed_date + 1.year}"
  end

  def calculate_amount
    amount = @customer.is_insured ? @customer.payment_fee.to_f : 0
    @customer.childs.each do |child|
      amount += child.payment_fee.to_f
    end
    amount
  end

  def adult_over_sixty?
    adult = @agreement.contract_members.select { |member| member[:age] > 60 }

    adult.present?
  end
end
