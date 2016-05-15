class Tier < ActiveRecord::Base
  include StateMachine

  before_validation :increment_display_order, on: :create

  belongs_to :box_office
  has_many :tickets

  default_scope { order(display_order: :desc) }

  delegate :draft?, :enabled?, :disabled?, :sold_out?, :closed?, to: :state

  def state
    (super || '').inquiry
  end

  def increment_display_order
    max_display_order = box_office.tiers.map(&:display_order).max || -1
    self.display_order = max_display_order + 1
  end
end
