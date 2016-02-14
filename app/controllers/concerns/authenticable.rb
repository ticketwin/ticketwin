module Authenticable
  def included(host)
    host.before_action :authenticate_with_token!
  end

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    unless user_signed_in?
      render_unauthenticated and return
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
