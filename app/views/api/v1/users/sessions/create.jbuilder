json.user do
    json.(current_user, :id, :email)
end
json.token @token