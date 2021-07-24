# frozen_string_literal: true

json.user do
  json.call(current_user, :id, :email)
end
