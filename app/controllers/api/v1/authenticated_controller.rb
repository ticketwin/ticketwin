module Api
  module V1
    class AuthenticatedController < ApiController
      include Authenticable
      before_action :authenticate_with_token!
    end
  end
end
