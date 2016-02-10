class EventSerializer < ActiveModel::Serializer
  attributes :event_id, :name, :organization_id, :state, :start_time, :end_time, :description
end
