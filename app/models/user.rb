class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token

  has_many :consents, as: :consentable

  has_one :membership
  has_one :organization, through: :membership

  before_create :set_defaults

  validates :email, presence: true, uniqueness: true, format: /@/
  validates :password, length: { in: 6..50 }, on: :create
  validates_confirmation_of :password
  validates :password_digest, presence: true
  validates :auth_token, uniqueness: true

  def regenerate_auth_token!
    regenerate_auth_token && save
  end

  def set_defaults
    self.last_touched_at ||= Time.zone.now
  end
end
