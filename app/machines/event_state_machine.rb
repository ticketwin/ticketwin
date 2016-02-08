class EventStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :new, initial: true
  state :published
  state :ongoing
  state :ended
  state :canceled

  event :publish do
    transition from: :new,       to: :published
  end

  event :start do
    transition from: :published, to: :ongoing
  end

  event :cancel do
    transition from: :new,       to: :canceled
    transition from: :published, to: :canceled
  end

  event :end do
    transition from: :ongoing,   to: :ended
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end

  guard_transition from: :published, to: :ongoing do |model|
    model.start_time <= Time.zone.now
  end
end
