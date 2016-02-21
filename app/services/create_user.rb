class CreateUser
  attr_reader :params, :user
  attr_accessor :errors

  def initialize(params)
    @params = params
    @errors = []
  end

  def execute
    @user = User.new user_params do |user|
      user.consents.build(consent_params)
    end

    @user.save

    if @user.errors.any?
      errors << @user.errors.messages
    elsif @user.consents.none? || @user.consents.any? { |c| !c.valid? }
      errors << { consents: 'Missing required consent(s)' }
    end
    self
  end

  def user_params
    params.except :consents
  end

  def consent_params
    params[:consents]
  end

  def errors?
    errors.any?
  end
end
