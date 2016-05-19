json.events do
  json.(@event, :event_id, :name, :state, :organization_id)
  json.(@event, :start_time, :end_time, :description)
  json.(@event, :image)
  json.(@event, :created_at, :updated_at)
end
