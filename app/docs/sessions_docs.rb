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
  end
end
