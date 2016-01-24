class ApiController < ApplicationController
  include ErrorRendering
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
end
