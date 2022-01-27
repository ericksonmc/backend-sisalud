# frozen_string_literal: true

class CoverageItemForm < BaseForm
  attr_reader :new_record

  attr_writer :id,
              :scale_items,
              :title

  validate :uniq_title

  def initialize(args: {}, coverage_item: nil)
    super(args)
    @args = args
    @coverage_item = coverage_item || CoverageItem.new(args)
    @new_record = @coverage_item.new_record?
    @models = [@coverage_item]
  end

  def before_validation
    assign_attributes_to_model
  end

  private

  def assign_attributes_to_model
    attributes = @args.tap do |args|
      args[:id] = @coverage_item.id
    end
    @coverage_item.assign_attributes(attributes)
  end

  def uniq_title
    return true unless CoverageItem.find_by(title: @coverage_item.title).present?

    raise StandardError.new, 'Coverage item ya registrado'
  end
end
