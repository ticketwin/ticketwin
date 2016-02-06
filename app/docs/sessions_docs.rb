module SessionsDocs
  include BaseDocs

  spec :create do
    api :POST, '/sessions', 'Authenticate a user'
    param :email, String, required: true
    param :password, String, required: true
  end

  spec :destroy do
    api :DELETE, '/sessions/:auth_token', 'Destroy the current session, i.e. sign out a user'
    param :auth_token, String, required: true
    error 401, 'Authentication required to destroy sessions'
    error 403, 'Authenticated user does not have permission to destroy session'
  end
end
