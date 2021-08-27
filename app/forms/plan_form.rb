# frozen_string_literal: true

class PlanForm < BaseForm
  attr_writer :age_limit,
              :age_min,
              :coverage,
              :coverage_items,
              :own,
              :payment_fee,
              :product_id,
              :title

  def initialize(args: {}, plan: nil)
    super(args)
    @args = args
    @plan = plan || Plan.new(args)
    @new_record = @plan.new_record?
    @models = [@plan]
  end

  def before_validation
    assign_attributes_to_admin_user
  end

  private

  def assign_attributes_to_admin_user
    attributes = @args.tap do |args|
      args[:id] = @plan.id
    end
    @plan.assign_attributes(attributes)
  end
end
