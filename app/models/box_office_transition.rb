class BoxOfficeTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  belongs_to :box_office, inverse_of: :transitions
end
