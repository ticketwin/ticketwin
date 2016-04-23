module StateMachine
  extend ActiveSupport::Concern

  included do
    has_many :transitions, class_name: "#{self.name}Transition", autosave: false

    delegate :can_transition_to?,
      :transition_to!,
      :transition_to,
      :current_state,
      :trigger!,
      :trigger,
      :available_events,
      to: :state_machine
  end

  def state_machine
    @state_machine ||= "#{self.class.name}StateMachine".constantize.new(
      self,
      transition_class: "#{self.class.name}Transition".constantize,
      association_name: :transitions
    )
  end
end
