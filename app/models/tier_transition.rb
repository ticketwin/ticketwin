class TierTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  belongs_to :tier, inverse_of: :tier_transitions
end
