json.array! @customers do |customer|
  json.activity customer.activity
  json.address customer.address
  json.age customer.age
  json.birthday customer.birthday
  json.coverage customer.coverage
  json.coverage_reference customer.coverage_reference
  json.created_at customer.created_at
  json.customer_code customer.customer_code
  json.dni customer.dni
  json.email customer.email
  json.firstname customer.firstname
  json.is_insured customer.is_insured
  json.last_name customer.last_name
  json.legal_representative customer.legal_representative
  json.main customer.main
  json.parent_id customer.parent_id
  json.phone customer.phone
  json.plan_id customer.plan_id
  json.second_name customer.second_name
  json.secondary_phone customer.secondary_phone
  json.sex customer.sex
  json.size customer.size
  json.updated_at customer.updated_at
  json.weight customer.weight
end