# frozen_string_literal: true

class UserPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && allow_blank?
    return if value.present? && value.length > 7

    record.errors.add(attribute, error_message)
  end

  private

  def allow_blank?
    options[:allow_blank]
  end

  def error_message
    E18n.et(:user_password, scope: [:models, :errors])
  end
end
