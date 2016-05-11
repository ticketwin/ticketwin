module EventsDocs
  include BaseDocs

  spec :create do
    api :POST, '/organizations/:organization_id/events', 'Create an event'
    param :organization_id, String, required: true
  end
end
