class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token

  validates :email, presence: true, uniqueness: true, format: /@/
  validates :password, length: { in: 6..50 }, on: :create
  validates_confirmation_of :password
  validates :auth_token, uniqueness: true
end
