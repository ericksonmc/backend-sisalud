json.array! @eventualities.each do |event|
  json.status I18n.t("eventuality.status.#{event.aasm_state}")
  json.amount event.amount
  json.date event.date
  json.event_type event.event_type
  json.observations event.observations
  json.password event.password
end
