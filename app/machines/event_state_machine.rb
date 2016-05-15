class EventStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :new, initial: true
  state :unpublished
  state :published
  state :concluded
  state :cancelled

  event :unpublish do
    transition from: :new, to: :unpublished
  end

  event :publish do
    transition from: :unpbulished, to: :published
  end

  event :conclude do
    transition from: :published, to: :concluded
  end

  event :cancel do
    transition from: :new,         to: :cancelled
    transition from: :unpublished, to: :cancelled
    transition from: :published,   to: :cancelled
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end
end
