# frozen_string_literal: true

class EventualityForm < BaseForm
  attr_reader :args

  attr_accessor :state_change

  attr_writer :event_type,
              :observations,
              :password,
              :agreement_id,
              :customer_id,
              :date,
              :eventuality_expenses_attributes

  validate :validate_state

  def initialize(args: {}, eventuality: nil, state_change: nil)
    super(args)
    @args = args
    @eventuality = eventuality || Eventuality.new(args)
    @new_record = @eventuality.new_record?
    @models = [@eventuality]
    @state_change = state_change
  end

  def before_validation
    assign_attributes_to_model
    create_base_expense
    parse_date
  end

  def after_save
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
    when 'cancelled'
      @eventuality.cancel!
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
  end

  def total
    @total ||= @eventuality.eventuality_expenses.inject(0) { |sum, item| sum + item.amount }
  end

  def validate_state
    return true if @new_record

    return true if @eventuality.pending?

    errors.add(:closed, 'Esta eventualidad esta cerrada o cancelada')

    raise StandardError.new, 'Esta eventualidad esta cerrada o cancelada'
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
