class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :created_at, :updated_at
end
