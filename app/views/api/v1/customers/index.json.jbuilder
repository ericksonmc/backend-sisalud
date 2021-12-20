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
    json.coverage customer.coverage
    json.remaining_coverage customer.remaining_coverage
    json.coverage_reference customer.coverage_reference
    json.plan customer.plan.title
    json.dni customer.dni
    json.is_insured customer.is_insured
    json.payment_fee customer.payment_fee
end