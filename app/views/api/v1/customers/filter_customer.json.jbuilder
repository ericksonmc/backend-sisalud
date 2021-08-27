json.array! @customers do |customer|
  json.full_name customer.full_name
  json.dni customer.dni
  json.agreement_id customer&.agreement&.id
  json.status customer&.agreement&.status
  json.plan do
    json.plan customer.plan&.title
    json.coverage customer.plan&.coverage
  end
  json.coverage_reference customer.coverage_reference
  json.coverage customer.coverage
  json.agreement do
    json.signed_date customer.agreement&.signed_date
    json.status customer.agreement&.aasm_state
    json.agreement_number customer.agreement&.agreement_number
  end
  json.beneficiaries customer.childs do |child|
    json.full_name child&.full_name
    json.dni child&.dni
    json.coverage_reference child&.coverage_reference
    json.coverage child&.coverage
    json.plan child.plan&.title
  end
end
