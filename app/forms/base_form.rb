# frozen_string_literal: true

class BaseForm
  include ActiveModel::Model

  # validate :validate_models

  def save(options = {})
    unless options[:validate] == false
      before_validation

      valid = valid?

      after_validation

      return false unless valid
    end

    ActiveRecord::Base.transaction do
      before_save
      (models || []).map { |model| model.save!() }

      after_save
    end

    after_commit

    true
  end

  def save!(options = {})
    save(options) || raise(ActiveRecord::RecordNotSaved.new(errors.full_messages.join(', '), self))
  end

  def valid?(context = nil)
    super.tap { errors.uniq! }
  end

  private

  attr_accessor :models

  def before_validation; end

  def after_validation; end

  def before_save; end

  def after_save; end

  def after_commit; end

  def validate_models
    (models || []).each do |model|
      promote_errors(model) if model.invalid?
    end
  end

  def promote_errors(model)
    model.errors.each do |error|
      errors.import(error, { attribute: model.try(:normalize_attribute, error.attribute) }.compact)
    end
  end
end
