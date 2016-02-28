class Api::V1::UsersController < Api::V1::AuthenticatedController
  include UsersDocs

  skip_before_action :authenticate_with_token!, only: :create
  before_action :skip_authorization, only: :create

  def create
    render_missing_parameters and return unless user_params[:password_confirmation]

    user = CreateUser.new(user_params).execute
    unless user.errors?
      @user = user.user
      render :show, status: :created
    else
      render_model_errors(user.errors)
    end
  end

  def show
    @user = User.find(params[:id])

    if @user
      authorize @user
    else
      render_not_found
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      render :show, status: :created
    else
      render_model_errors @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:users).permit(
      :email, :password, :password_confirmation,
      consents: [:consent_type, :ip_address]
    )
  end
end
