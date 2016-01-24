class User < ActiveRecord::Base

  has_secure_token :api_token

  validates :api_token, uniqueness: true
end
