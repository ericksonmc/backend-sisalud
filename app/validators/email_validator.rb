# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && allow_blank?
    return if value&.match(URI::MailTo::EMAIL_REGEXP) &&
              satisfies_additional_constraints?(value)

    record.errors.add(attribute, error_message)
  end

  private

  def satisfies_additional_constraints?(value)
    local_part, domain = value.split('@')

    !local_part.starts_with?('.') && domain.count('.').positive? && valid_tld?(domain)
  end

  def valid_tld?(domain)
    size = domain.split('.').last.length
    size > 1
  end

  def allow_blank?
    options[:allow_blank]
  end

  def error_message
    'Invalid Email'
  end
end
