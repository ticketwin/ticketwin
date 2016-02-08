class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  scope :except_ownership, -> { where(ownership: false) }

  validates :organization, presence: true
  validates :user,         presence: true
end
