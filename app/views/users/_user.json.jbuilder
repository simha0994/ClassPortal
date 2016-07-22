json.extract! user, :id, :email, :usertype, :created_at, :updated_at
json.url user_url(user, format: :json)