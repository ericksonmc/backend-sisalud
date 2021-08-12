json.array! @customers do |customer|
  json.full_name customer.full_name
  json.dni customer.dni
  json.agreement_id customer.agreement.id
  json.status customer.agreement.status
end