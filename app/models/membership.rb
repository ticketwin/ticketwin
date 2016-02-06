class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  scope :except_ownership, -> { where(ownership: false) }
end
