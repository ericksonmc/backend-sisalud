# frozen_string_literal: true

json.user do
    json.(current_user, :id, :email)
end