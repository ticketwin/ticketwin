class Api::V1::UsersController < Api::V1::AuthenticatedController
  skip_before_action :authenticate_with_token!, only: :create
  before_action :skip_authorization, only: :create

  def show
    @user = User.find(params[:id])

    if @user
      authorize @user
      respond_with @user
    else
      render_not_found
    end
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
    @user = User.find(params[:id])
    authorize @user

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
