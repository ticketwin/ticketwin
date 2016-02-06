class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  has_one :ownership, -> { where(ownership: true) }, class_name: 'Membership'
  has_one :owner, through: :ownership, source: :user

  has_and_belongs_to_many :venues
end
