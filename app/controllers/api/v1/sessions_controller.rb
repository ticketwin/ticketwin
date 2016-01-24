module Api
  module V1
    class SessionsController < ApiController
      def create
        @user = User.find_by(email: session_params[:email])

        if @user && @user.valid_password?(session_params[:password])
          sign_in @user
          @user.regenerate_api_token
          @user.save

          render json: @user, status: :ok, location: [:api, @user]
        else
          render_invalid_request :invalid_email_or_password
        end
      end

      def destroy
        @user = User.find_by(api_token: params[:id])
        @user.regenerate_api_token
        @user.save

        head :no_content
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
