module EventsDocs
  include BaseDocs

  spec :create do
    api :POST, '/organizations/:organization_id/events', 'Create an event'
    param :name, String, required: true
    param :description, String, required: true
    param :image, String, required: false
    param :start_time, String, required: true
    param :end_time, String, required: true
    param :organization_id, Integer, required: false
  end

  error 422, 'Resource has errors, unprocessable entity, possibly malformed request'
end
