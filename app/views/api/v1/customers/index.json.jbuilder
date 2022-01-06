json.total_pages @pagination.total_pages
json.count @pagination.count
json.first_page @pagination.first_page?
json.last_page @pagination.last_page?
json.current_page @pagination.current_page
json.total_count @customers.count
json.data @pagination do |customer|
  json.id customer.id
  json.name customer.full_name
  json.birthday customer.birthday
  json.coverage customer.coverage.to_f.round(2)
  json.remaining_coverage customer.remaining_coverage.to_f.round(2)
  json.coverage_reference customer.coverage_reference.to_f.round(2)
  json.plan customer&.plan&.title
  json.dni customer.dni
  json.is_insured customer.is_insured
  json.payment_fee customer.payment_fee
end