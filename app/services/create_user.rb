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

    errors << @user.errors.full_messages if @user.errors.any?
    errors << 'Consents are invalid or missing' if invalid_consents?

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

  def invalid_consents?
    @user.consents.none? || @user.consents.any? { |c| !c.valid? }
  end
end
