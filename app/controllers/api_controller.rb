class ApiController < ApplicationController

  respond_to :json, :tcktwn
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_missing_parameters
  rescue_from ActionController::RoutingError, with: :render_no_route

  # pundit checks every action to make sure authorization is checked
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  prepend_view_path 'app/views/api/v1'
end
