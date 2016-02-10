class EventSaleTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  belongs_to :event_sale, inverse_of: :event_sale_transitions
end
