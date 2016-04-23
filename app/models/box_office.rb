class BoxOffice < ActiveRecord::Base
  include StateMachine

  belongs_to :event

  delegate :new?, :pre_sale?, :on_sale?, :post_sale?, to: :state

  def state
    (super || '').inquiry
  end
end
