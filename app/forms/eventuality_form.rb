# frozen_string_literal: true

class EventualityForm < BaseForm
  attr_reader :args

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
  end

  def before_validation
    assign_attributes_to_model
  end

  private

  def assign_attributes_to_model
    attributes = @args.tap do |args|
      args[:id] = @eventuality.id
    end
    @eventuality.assign_attributes(attributes)
  end
end
