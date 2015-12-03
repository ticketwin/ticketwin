module Api
  module V1
    class SessionsController < ApiController
      def create
        @user = User.find_by(email: session_params[:email])

        if @user.valid_password? session_params[:password]
          sign_in @user, store: false
          @user.regenerate_api_token
          @user.save
          render json: @user, status: :ok, location: [:api, @user]
        else
          render json: { errors: 'Invalid email or password' }, status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
