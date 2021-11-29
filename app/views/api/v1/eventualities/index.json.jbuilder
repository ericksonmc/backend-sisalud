json.array! @eventualities do |event|
  json.id event.id
  json.aasm_state event.aasm_state
  json.status I18n.t("eventuality.status.#{event.aasm_state}")
  json.amount event.amount
  json.date event.date&.strftime('%d/%m/%Y')
  json.event_type event.event_type
  json.observations event.observations
  json.updated_at event.updated_at&.strftime('%d/%m/%Y')
  json.agreement event.agreement
  json.customer do
    json.full_name event.agreement.customer.full_name
    json.dni event.agreement.customer&.dni
  end
  json.agent do
    json.full_name event.agreement.user.to_s
    json.agent_code event.agreement.user.agent_code
  end
end