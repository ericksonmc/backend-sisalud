# frozen_string_literal: true

class EventualityForm < BaseForm
  attr_reader :args

  attr_accessor :state_change

  attr_writer :event_type,
              :observations,
              :password,
              :agreement_id,
              :customer_id

  def initialize(args: {}, eventuality: nil)
    super(args)
    @args = args
    @eventuality = eventuality || Eventuality.new(args)
    @new_record = @eventuality.new_record?
    @models = [@eventuality]
    @state_change = state_change
  end

  def before_validation
    assign_attributes_to_model
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
    case state_change
    when 'close'
      @eventuality.close!
    when 'cancelled'
      @eventuality.cancelled!
    end
  end
end
