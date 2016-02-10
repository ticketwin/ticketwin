class Event < ActiveRecord::Base
  auditable

  belongs_to :organization
  has_many :transitions, class_name: 'EventTransition', autosave: false
  has_one :box_office

  validates :name,         presence: true
  validates :organization, presence: true
  validates :state,        presence: true
  validates :start_time,   presence: true
  validates :end_time,     presence: true

  delegate :can_transition_to?,
    :transition_to!,
    :transition_to,
    :current_state,
    :trigger!,
    :trigger,
    :available_events,
    to: :state_machine

  delegate :new?, :published?, :ongoing?, :ended?, :canceled?, to: :state

  def state
    (super || '').inquiry
  end

  private

  def state_machine
    @state_machine ||= EventStateMachine.new(self, transition_class: EventTransition, association_name: :transitions)
  end
end
