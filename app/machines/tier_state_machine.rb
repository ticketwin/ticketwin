class TierStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :draft, initial: true
  state :enabled
  state :disabled
  state :sold_out
  state :closed

  event :enable do
    transition from: :draft,    to: :enabled
    transition from: :disabled, to: :enabled
    transition from: :sold_out, to: :enabled
  end

  event :disable do
    transition from: :draft,    to: :disabled
    transition from: :enabled,  to: :disabled
    transition from: :sold_out, to: :disabled
  end

  event :sell_out do
    transition from: :enabled,  to: :sold_out
    transition from: :disabled, to: :sold_out
  end

  event :close do
    transition from: :enabled,  to: :closed
    transition from: :disabled, to: :closed
    transition from: :sold_out, to: :closed
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end
end
