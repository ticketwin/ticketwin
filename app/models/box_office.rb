class BoxOffice < ActiveRecord::Base
  belongs_to :event
  has_many :tiers
end
