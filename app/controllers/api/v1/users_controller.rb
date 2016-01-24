class Api::V1::UsersController < AuthenticatedController
  skip_before_action :authenticate_with_token!, only: [:show, :create]

  def show
    respond_with current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: [:api, @user]
    else
      render_model_errors @user.errors
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 201, location: [:api, @user]
    else
      render_model_errors @user.errors
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
