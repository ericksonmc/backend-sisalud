# frozen_string_literal: true

json.array! @agreements.order(:agreement_number) do |agree|
  json.id agree.id
  json.agreement_number agree.agreement_number
  json.amount agree.amount
  json.payment_method agree.payment_method
  json.signed_date agree.signed_date&.strftime('%d/%m/%Y')
  json.status agree.status
  json.aasm_state agree.aasm_state
  json.customer do
    json.full_name agree.customer.full_name
    json.plan agree.customer&.plan&.title
    json.dni agree.customer&.dni
  end
  json.agent do
    json.full_name agree.user.to_s
    json.agent_code agree.user.agent_code
  end
end
