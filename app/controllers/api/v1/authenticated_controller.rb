class Api::V1::AuthenticatedController < ApiController
  include Authenticable
  include Expirable
end
