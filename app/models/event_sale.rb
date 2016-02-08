class EventSale < ActiveRecord::Base
  belongs_to :event

  has_many :transitions, class_name: 'EventSaleTransition', autosave: false

  delegate :can_transition_to?,
    :transition_to!,
    :transition_to,
    :current_state,
    :trigger!,
    :trigger,
    :available_events,
    to: :state_machine

  delegate :new?, :pre_sale?, :on_sale?, :post_sale?, to: :state

  def state
    (super || '').inquiry
  end

  private

  def state_machine
    @state_machine ||= EventSaleStateMachine.new(self, transition_class: EventSaleTransition, association_name: :transitions)
  end
end
