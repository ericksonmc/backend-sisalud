json.array! @eventualities do |event|
  json.id event.id
  json.aasm_state event.aasm_state
  json.status I18n.t("eventuality.status.#{event.aasm_state}")
  json.amount event.amount
  json.date event.date
  json.event_type event.event_type
  json.observations event.observations
  json.agreement event.agreement
  json.customer event.customer
end