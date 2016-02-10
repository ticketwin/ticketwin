module UsersDocs
  include BaseDocs

  spec :create do
    api :POST, '/users', 'Create a user'
    param :email, String, required: true
    param :password, String, required: true
    param :password_confirmation, String, required: true
    error 422, 'Resource has errors, unprocessable entity, possibly malformed request params'
  end

  spec :show do
    api :GET, '/users/:user_id', 'Show a user'
    param :id, Integer, required: true
    error 401, 'Authentication required to perform action'
    error 403, 'Authenticated user does not have permission to perform action'
    error 404, 'Requested resource does not exist'
  end

  spec :update do
    api :PUT, '/users/:user_id', 'Update a user'
    param :id, Integer, required: true
    param :email, String, required: false
  end
end
