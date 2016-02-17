class Api::V1::AuthenticatedController < ApiController
  include Authenticable
  include Expirable

  before_action :authenticate_with_token!
  before_action :expire_session_after_timeout
end
