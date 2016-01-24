module ErrorRendering
  private

  def render_not_found
    render_error('Not Found', :not_found)
  end

  def render_invalid_request(message = :invalid_request)
    render_error(message.to_s.humanize, :unprocessable_entity)
  end

  def render_model_errors(errors)
    render_error(errors, :unprocessable_entity)
  end

  def render_error(error, status)
    render json: { errors: error }, status: status
  end
end
