class Event < ActiveRecord::Base
  include StateMachine

  auditable
  mount_uploader :image, AssetUploader

  belongs_to :organization
  has_one :box_office

  validates :name,         presence: true
  validates :organization, presence: true
  validates :state,        presence: true
  validates :start_time,   presence: true
  validates :end_time,     presence: true

  delegate :new?, :published?, :ongoing?, :ended?, :canceled?, to: :state

  def state
    (super || '').inquiry
  end
end
