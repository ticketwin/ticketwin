module OrganizationsDocs
  include BaseDocs

  spec :create do
    api :POST, '/organizations', 'Create an organization'
    param :user_id, String, 'User id for intended owner', required: true
    param :name, [String, NilClass], 'Organization name; expects `null` for anonymous organizations', required: false
  end

  spec :show do
    api :GET, '/organizations/:organization_id', 'Show an organization'
    param :id, Integer, required: true
  end
end
