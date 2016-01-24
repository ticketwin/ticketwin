class Api::V1::AuthenticatedController < ApiController
  include Authenticable
  before_action :authenticate_with_token!
end
