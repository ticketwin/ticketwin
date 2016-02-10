class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :email, :auth_token, :created_at, :updated_at
end
