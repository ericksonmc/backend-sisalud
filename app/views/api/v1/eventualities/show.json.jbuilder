json.id @eventuality.id 
json.aasm_state @eventuality.aasm_state 
json.status I18n.t("eventuality.status.#{@eventuality.aasm_state}") 
json.amount @eventuality.amount 
json.date @eventuality.date 
json.event_type @eventuality.event_type 
json.observations @eventuality.observations 
json.agreement @eventuality.agreement 
json.customer @eventuality.customer
json.eventuality_expenses @eventuality.eventuality_expenses.map do |expense|
  json.id expense.id
  json.amount expense.amount
  json.scale do
    json.id expense.scale.id
    json.amount expense.scale.amount
    json.category expense.scale.category
    json.status expense.scale.status
    json.title expense.scale.title
  end
end
