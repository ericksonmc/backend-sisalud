json.agreement_number @agreement.agreement_number
json.amount @agreement.amount
json.payment_method @agreement.payment_method
json.signed_date @agreement.signed_date
json.status @agreement.status
json.agent do
  json.user_id @agreement.user.id
  json.full_name @agreement.user.to_s
end
json.customer do
  json.activity @agreement.customer.activity
  json.address @agreement.customer.address
  json.age @agreement.customer.age
  json.birthday @agreement.customer.birthday
  json.coverage @agreement.customer.coverage
  json.coverage_reference @agreement.customer.coverage_reference
  json.customer_code @agreement.customer.customer_code
  json.dni @agreement.customer.dni
  json.email @agreement.customer.email
  json.firstname @agreement.customer.firstname
  json.id @agreement.customer.id
  json.is_insured @agreement.customer.is_insured
  json.last_name @agreement.customer.last_name
  json.legal_representative @agreement.customer.legal_representative
  json.main @agreement.customer.main
  json.phone @agreement.customer.phone
  json.second_name @agreement.customer.second_name
  json.secondary_phone @agreement.customer.secondary_phone
  json.sex @agreement.customer.sex
  json.size @agreement.customer.size
  json.weight @agreement.customer.weight
  json.plan_id @agreement.customer.plan_id
  json.diseases @agreement.customer.diseases do |disease|
    json.other_description disease.other_description(@agreement.customer)
    json.has_description disease.has_description
    json.id disease.id
    json.list_diases disease.list_diases
    json.order disease.order
    json.title disease.title
  end
  json.plan do
    json.title @agreement.customer.plan&.title
    json.payment_fee @agreement.customer.plan&.payment_fee
    json.coverage @agreement.customer.plan&.coverage
  end
  json.beneficiaries @agreement.customer.childs do |child|
    json.firstname child.firstname
    json.second_name child.second_name
    json.last_name child.last_name
    json.dni child.dni
    json.birthday child.birthday
    json.age child.age
    json.sex child.sex
    json.size child.size
    json.plan_id child.plan_id
    json.is_insured child.is_insured
    json.weight child.weight
    json.plan_id child.plan_id
    json.diseases child.diseases do |disease|
      json.other_description disease.other_description(child)
      json.has_description disease.has_description
      json.id disease.id
      json.list_diases disease.list_diases
      json.order disease.order
      json.title disease.title
    end
    json.plan do
      json.title child.plan.title
      json.payment_fee child.plan.payment_fee
      json.coverage child.plan.coverage
    end
  end
end
