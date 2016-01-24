module Authenticable
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    unless user_signed_in?
      render json: { errors: 'Not authenticated' }, status: :unauthorized and return
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
