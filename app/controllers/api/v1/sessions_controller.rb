class Api::V1::SessionsController < ApiController
  include SessionsDocs

  before_action :skip_authorization

  def create
    @user = User
      .find_by(email: session_params[:email].downcase)
      &.authenticate(session_params[:password])

    if @user
      @user.regenerate_auth_token!

      render json: @user, status: :ok, location: [:api, @user], root: 'users'
    else
      render_invalid_request :invalid_email_or_password
    end
  end

  def destroy
    @user = User.find_by(auth_token: params[:id])
    @user.regenerate_auth_token!

    head :no_content
  end

  private

  def session_params
    params.require(:sessions).permit(:email, :password)
  end
end
