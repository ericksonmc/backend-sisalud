json.array! @scales do |scale|
  json.id scale.id
  json.title scale.title
  json.amount scale.amount
  json.category scale.category
  json.pretty_category I18n.t("scale.category.#{scale.category}")
  json.status I18n.t("scale.status.#{scale.status}")
end
