class BoxOfficeStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :new, initial: true
  state :open
  state :closed

  event :open do
    transition from: :new,    to: :open
  end

  event :close do
    transition from: :new,    to: :closed
    transition from: :open,   to: :closed
  end

  event :reopen do
    transition from: :closed, to: :open
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end
end
