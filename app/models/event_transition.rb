class EventTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  belongs_to :event, inverse_of: :event_transitions
end
