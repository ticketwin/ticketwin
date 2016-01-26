class Api::V1::SessionsController < ApiController
  before_action :skip_authorization

  def create
    @user = User
      .find_by(email: session_params[:email].downcase)
      .authenticate(session_params[:password])

    if @user
      @user.regenerate_auth_token
      @user.save

      render json: @user, status: :ok, location: [:api, @user]
    else
      render_invalid_request :invalid_email_or_password
    end
  end

  def destroy
    @user = User.find_by(auth_token: params[:id])
    @user.regenerate_auth_token
    @user.save

    head :no_content
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
