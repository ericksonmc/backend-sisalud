# frozen_string_literal: true

class ScaleForm < BaseForm
  attr_writer :amount,
              :category,
              :id,
              :status,
              :title

  def initialize(args: {}, scale: nil)
    super(args)
    @args = args
    @scale = scale || Scale.new(args)
    @new_record = @scale.new_record?
    @models = [@scale]
  end

  def before_validation
    assign_attributes_to_model
  end

  private

  def assign_attributes_to_model
    attributes = @args.tap do |args|
      args[:id] = @scale.id
    end
    @scale.assign_attributes(attributes)
  end
end
