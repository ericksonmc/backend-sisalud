# frozen_string_literal: true

module ApplicationHelper
  def pretty_key_event(label)
    I18n.t("eventuality.event_type.#{Eventuality.event_types.invert[label]}")
  end
end
