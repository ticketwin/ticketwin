class ApiController < ApplicationController
  include ErrorRendering

  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_missing_parameters

  # pundit checks every action to make sure authorization is checked
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def default_serializer_options
    { root: params[:controller].split(?/).last }
  end
end
