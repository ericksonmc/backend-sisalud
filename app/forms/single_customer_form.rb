# frozen_string_literal: true

class SingleCustomerForm < BaseForm
  attr_reader :args, :customer, :step, :user, :new_record

  attr_accessor :id_attachment

  attr_writer :activity,
              :address,
              :age,
              :birthday,
              :childs,
              :coverage,
              :coverage_reference,
              :customer_code,
              :dni,
              :diagnosis,
              :email,
              :firstname,
              :is_insured,
              :last_name,
              :legal_representative,
              :main,
              :parent_id,
              :phone,
              :payment_fee,
              :plan_id,
              :second_name,
              :secondary_phone,
              :sex,
              :size,
              :weight

  def initialize(args: {}, customer: nil)
    super(args)
    @args = args
    @customer = customer || Customer.new(args)
    @new_record = @customer.new_record?
    @models = [@customer]
  end

  def before_validation
    assign_attributes_to_model unless new_record
  end

  private

  def assign_attributes_to_model
    attributes = @args.tap do |args|
      args[:id] = @customer.id
    end
    @customer.assign_attributes(attributes)
  end
end
