module Expirable

  def expire_session_after_timeout
    return true unless current_user

    if current_user.last_touched_at <= session_timeout.minutes.ago
      current_user.regenerate_auth_token!
      render_unauthenticated and return
    else
      current_user.touch :last_touched_at
    end
  end

  def session_timeout
    if current_user.admin?
      AppConfig.sessions.admin_timeout
    else
      AppConfig.sessions.timeout
    end
  end
end
