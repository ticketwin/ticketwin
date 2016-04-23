class EventStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :new, initial: true
  state :published
  state :live
  state :ended
  state :canceled

  event :publish do
    transition from: :new,       to: :published
  end

  event :start do
    transition from: :published, to: :live
  end

  event :end do
    transition from: :live,      to: :ended
  end

  event :cancel do
    transition from: :new,       to: :canceled
    transition from: :published, to: :canceled
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end

  guard_transition to: :live do |model|
    model.start_time <= Time.zone.now
  end
end
