class EventStateMachine
  include Statesman::Machine

  state :new, initial: true
  state :published
  state :ongoing
  state :ended
  state :canceled

  transition from: :new,       to: [:published, :canceled]
  transition from: :published, to: [:ongoing, :canceled]
  transition from: :ongoing,   to: :ended
end
