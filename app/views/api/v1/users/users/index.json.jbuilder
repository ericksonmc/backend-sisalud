json.array! @users do |user|
  json.id user.id
  json.active user.active
  json.agent_code user.agent_code
  json.email user.email
  json.first_name user.first_name
  json.last_name user.last_name
  json.remember_created_at user.remember_created_at
  json.reset_password_sent_at user.reset_password_sent_at
  json.reset_password_token user.reset_password_token
  json.role I18n.t("user.role.#{user.role}")
end