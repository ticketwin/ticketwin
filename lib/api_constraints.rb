class ApiConstraints
  def initialize(version: nil, default: false)
    @version = version
    @default = default
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.ticketwin.v#{@version}")
  end
end
