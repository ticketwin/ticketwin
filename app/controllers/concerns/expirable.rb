module Expirable
  def included(host)
    host.before_action :expire_session_after_timeout
  end

  def expire_session_after_timeout
    return true unless current_user

    if current_user.last_touched_at <= session_timeout.minutes.ago
      render_unauthenticated and return
    else
      current_user.touch :last_touched_at
    end
  end

  def session_timeout
    AppConfig.sessions.timeout
  end
end
