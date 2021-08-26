# frozen_string_literal: true

class CustomerForm < BaseForm
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
              :plan_id,
              :second_name,
              :secondary_phone,
              :sex,
              :size,
              :weight

  validate :email_presence_for_update

  def initialize(args: {}, customer: nil, step: nil, user: nil, childs: [])
    super(args)
    @args = args
    @customer = customer || Customer.new(args)
    @new_record = @customer.new_record?
    @step = step
    @user = user
    @models = [@customer]
    @childs = childs
  end

  def after_save
    save_childs
    set_coverage_to_childs
    save_agreement
    save_diagnosis(@customer)
    save_attachments(@customer)
  end

  def before_save
    set_main
    set_insurance_data
  end

  def before_validation
    assign_attributes_to_admin_user
  end

  private

  def save_diagnosis(param)
    return unless param.diagnosis.present?

    customer = Customer.find(param.id)
    customer.customer_diseases.destroy_all unless @new_record
    param.diagnosis.each do |disease|
      customer.customer_diseases.create({
                                         disease_id: disease['id'],
                                         description: disease['description']
                                       })
    end
  end

  def assign_attributes_to_admin_user
    attributes = args.tap do |args|
      args[:id] = @customer.id
    end

    @customer.assign_attributes(attributes)
  end

  def email_presence_for_update
    return if new_record
  end

  def save_childs
    return if @childs.blank?

    @childs[:childs].each do |child|
      if child['id'].to_i.zero?
        customer = @customer.childs.create(child.except('id'))
      else
        customer = Customer.find(child['id'])
        customer.update(child)
      end
      child["id"] = customer.id
      save_diagnosis(OpenStruct.new(child))
      save_attachments(OpenStruct.new(child))
    end
  end

  def set_coverage_to_childs
    @customer.childs.each do |child|
      child.coverage_reference = child.plan.coverage
      child.coverage = amount_coverage(child)
      child.save!
    end
  end

  def set_insurance_data
    return unless @customer.plan_id.present?

    @customer.coverage_reference = @customer.plan.coverage
    @customer.coverage = amount_coverage(@customer)
  end

  def amount_coverage(customer)
    return customer.coverage if customer.coverage.present?

    0
  end

  def save_agreement
    return unless @customer.main

    agreement.save!
  rescue StandardError => e
    Rails.logger.info do
      'Error while creating the agreement for customer.'\
        "Customer Email: #{@customer&.email}. Error message: #{e.message}"
    end
  end

  def set_main
    return if @customer.parent_id.present?

    @customer.main = true
  end

  def save_attachments(customer_param)
    return unless customer_param.id_attachment.present?

    attachments(customer_param.id_attachment).update(fileable_id: customer_param.id)
  end

  def agreement
    @agreement ||= AgreementForm.new(customer: @customer, step: @step, user: @user)
  end

  def attachments(id_attachment)
    @attachments ||= Attachment.find(id_attachment)
  end
end
