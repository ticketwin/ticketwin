class Event < ActiveRecord::Base
  belongs_to :organization

  has_many :transitions, class_name: 'EventTransition', autosave: false

  delegate :can_transition_to?,
    :transition_to!,
    :transition_to,
    :current_state,
    to: :state_machine

  delegate :new?, :published?, :ongoing?, :ended?, :canceled?, to: :state

  private

  def state_machine
    @state_machine ||= EventStateMachine.new(self, transition_class: EventTransition, association_name: :transitions)
  end

  def state
    super.inquiry
  end
end
