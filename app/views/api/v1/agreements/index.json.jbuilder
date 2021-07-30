# frozen_string_literal: true

json.array! @agreements do |agree|
  json.agreement_number agree.agreement_number
  json.amount agree.amount
  json.payment_method agree.payment_method
  json.signed_date agree.signed_date
  json.status agree.status
  json.customer agree.customer
  json.agent do
    json.full_name agree.user.to_s
    json.agent_code agree.user.agent_code
  end
end
