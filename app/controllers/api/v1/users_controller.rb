module Api
  module V1
    class UsersController < AuthenticatedController
      skip_before_action :authenticate_with_token!, only: [:show, :create]

      def show
        @user = User.find(params[:id])
        respond_with @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created, location: [:api, @user]
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: 201, location: [:api, @user]
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
