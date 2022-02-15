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
    create_base_expense
    parse_date
  end

  def after_save
    update_state if state_change.present?
    update_coverage
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

  def parse_date
    return unless @new_record

    @eventuality.date = DateTime.parse(@args['date']) # '%Y-%m-%d %H:%M:%S+4'
  end

  def update_coverage
    customer.update_coverage(total)
    set_amount
  end

  def update_expenses
    @eventuality.set_charded_expenses
  end

  def set_amount
    @eventuality.update(amount: @eventuality.amount.to_f + total)
  end

  def total
    @total ||= @eventuality.calculate_total
  end

  def validate_state
    return true if @new_record

    return true if @eventuality.pending?

    return true if state_change['state_change'] == 'reopen'

    return true if @eventuality.reopened?

    errors.add(:closed, 'Esta eventualidad esta cerrada o cancelada')

    raise StandardError.new, 'Esta eventualidad esta cerrada o cancelada'
  end

  def beneficiary_insured
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
      scale = Scale.find(3)
    when 'medical_consultation'
      scale = Scale.find(1)
    when 'specialized_medical_consultation'
      scale = Scale.find(2)
    end
    {
      amount: scale.amount,
      scale_id: scale.id
    }
  end
end
