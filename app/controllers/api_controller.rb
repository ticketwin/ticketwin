class ApiController < ApplicationController

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render json: { errors: 'Not Found' }, status: :not_found
  end
end
