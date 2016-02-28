class ApplicationController < ActionController::Base
  include ErrorRendering
  include Pundit

  protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  def routing_error
    render_route_not_found
  end
end
