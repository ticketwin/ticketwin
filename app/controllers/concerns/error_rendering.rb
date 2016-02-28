module ErrorRendering
  private

  def render_not_found
    render_error 'Not Found', :not_found
  end

  def render_invalid_request(message = :invalid_request)
    render_error message.to_s.humanize, :unprocessable_entity
  end

  def render_model_errors(errors)
    render_error errors.flatten.uniq, :unprocessable_entity
  end

  def render_unauthenticated
    render_error 'Not authenticated', :unauthorized
  end

  def render_forbidden
    render_error 'Unauthorized to perform this action', :forbidden
  end

  def render_missing_parameters
    render_invalid_request 'Missing required parameters'
  end

  def render_route_not_found
    render_error 'No matching route found', :not_found
  end

  def render_error(error, status)
    render json: { errors: error }, status: status
  end
end
