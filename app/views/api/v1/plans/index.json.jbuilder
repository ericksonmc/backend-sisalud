json.array! @plans.each do |plan|
  json.id plan.id
  json.age_limit plan.age_limit
  json.age_min plan.age_min
  json.coverage plan.coverage
  json.own plan.own
  json.payment_fee plan.payment_fee
  json.title plan.title
  json.product_id plan.product_id
  json.coverage_items_plans plan.coverage_items_plans
end