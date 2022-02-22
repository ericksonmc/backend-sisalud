# frozen_string_literal: true

class EventualityForm < BaseForm
  attr_reader :args, :new_record

  attr_accessor :state_change

  attr_writer :event_type,
              :observations,
              :password,
              :agreement_id,
              :customer_id,
              :date,
              :assessment,
              :eventuality_expenses_attributes,
              :eventuality_expense_manuals_attributes
  validate :validate_active_agreement
  validate :validate_state
  validate :beneficiary_insured
  validate :beneficiary_has_coverage

  def initialize(args: {}, eventuality: nil, state_change: nil)
    super(args)
    @args = args
    @eventuality = eventuality || Eventuality.new(args)
    @new_record = @eventuality.new_record?
    @models = [@eventuality]
    @state_change = state_change
  end

  def before_validation
    assign_attributes_to_model unless new_record
    create_base_expense if @new_record
    parse_date
  end

  def after_save
    update_base_expenses
    update_state if state_change.present?
  end

  private

  def assign_attributes_to_model
    attributes = @args.tap do |args|
      args[:id] = @eventuality.id
    end
    @eventuality.assign_attributes(attributes)
  end

  def update_state
    case state_change['state_change']
    when 'close'
      @eventuality.close!
      update_coverage
      update_expenses
    when 'cancelled'
      @eventuality.cancel!
    when 'reopen'
      @eventuality.reopen!
    when 'close_again'
      @eventuality.close_again!
      update_coverage
      update_expenses
    end
  end

  def create_base_expense
    return unless @new_record

    @eventuality.eventuality_expenses_attributes = [find_scale(@eventuality.event_type)]
  end

  def update_base_expenses
    customer.update_coverage(total)
    @eventuality.set_charged_expenses
  end

  def parse_date
    return unless @new_record

    @eventuality.date = DateTime.parse(@args['date']) # '%Y-%m-%d %H:%M:%S+4'
  end

  def update_coverage
    @eventuality.update(amount: @eventuality.amount.to_f + @eventuality.total_expenses)
    customer.update_coverage(total)
  end

  def update_expenses
    @eventuality.set_charged_expenses
  end

  def total
    @total ||= @eventuality.calculate_total_unloaded
  end

  def validate_state
    return true if @new_record

    return true if @eventuality.pending?

    return true if state_change['state_change'] == 'reopen'

    return true if @eventuality.reopened?

    errors.add(:closed, 'Esta eventualidad esta cerrada o cancelada')

    raise StandardError.new, 'Esta eventualidad esta cerrada o cancelada'
  end

  def validate_active_agreement
    return true if !customer.act_agreement.active? && state_change['state_change'] == 'close'

    return true if customer.act_agreement.active?

    raise StandardError.new, "Esta poliza se encuentra: #{I18n.t("agreements.status.#{customer.act_agreement.aasm_state}")}"
  end

  def beneficiary_insured
    return true if !customer.is_insured && state_change['state_change'] == 'close'

    return true if customer.is_insured

    raise StandardError.new, 'El beneficiario no se encuentra asegurado'
  end

  def beneficiary_has_coverage
    return true if customer.coverage < customer.coverage_reference

    raise StandardError.new, 'El beneficiario no tiene covertura suficiente'
  end

  def customer
    @customer ||= Customer.find(@eventuality.customer_id)
  end

  def find_scale(type)
    case type
    when 'emergency'
      scale = Scale.find(54)
    when 'medical_consultation'
      scale = Scale.find(31)
    when 'specialized_medical_consultation'
      scale = Scale.find(32)
    end
    {
      amount: scale.amount,
      scale_id: scale.id
    }
  end
end
