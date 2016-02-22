require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    before do
      @user = create :user
      api_authorization_header @user.auth_token
    end

    it 'returns the information about a reporter on a hash' do
      get :show, id: @user.user_id
      expect(json_response[:users][:email]).to eql @user.email
    end

    it 'returns 200' do
      get :show, id: @user.user_id
      expect(response.status).to eq 200
    end

    context 'when a session times out' do
      before do
        @user.update_column(:last_touched_at, 31.minutes.ago)
      end

      it 'deauthenticates the user' do
        get :show, id: @user.user_id
        expect(response.status).to eq 401
        expect(json_response[:errors]).to eq 'Not authenticated'
      end
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      let(:user_params) do
        {
          email: 'donald.trump@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          consents: [{
            consent_type: 'terms_of_service',
            ip_address: '127.0.0.1'
          }]
        }
      end

      before do
        post :create, { users: user_params }
      end

      it 'renders the json representation for the user record just created' do
        expect(json_response[:users][:email]).to eql 'donald.trump@example.com'
      end

      it 'responds with 201' do
        expect(response.status).to eq 201
      end
    end

    context 'when password confirmation does not match password' do
      before do
        @user_attributes = attributes_for :user
        post :create, { users: @user_attributes.merge(password_confirmation: 'abcdefghijk') }
      end

      it 'renders an error' do
        expect(json_response[:errors]).to include "Password confirmation doesn't match Password"
      end

      it 'responds with 422' do
        expect(response.status).to eq 422
      end
    end

    context 'without consents' do
      let(:user_params) do
        {
          email: 'donald.trump@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          consents: []
        }
      end

      before do
        post :create, { users: user_params }
      end

      it 'renders an error' do
        expect(response.status).to eq 422
        expect(json_response[:errors]).to include 'Consents are invalid or missing'
      end
    end

    context 'when email is not valid' do
      before do
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { users: @invalid_user_attributes }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        expect(json_response[:errors]).to include "Email can't be blank"
      end

      it 'responds with 422' do
        expect(response.status).to eq 422
      end
    end

    context 'when password confirmation is not included' do
      before do
        @invalid_user_attributes = { email: 'bob@example.com', password: "12345678" }
        post :create, { users: @invalid_user_attributes }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        expect(json_response[:errors]).to eq 'Missing required parameters'
      end

      it 'responds with 422' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        @user = create :user
        api_authorization_header @user.auth_token
        patch :update, { id: @user.id,
                         users: { email: 'newmail@example.com' } }
      end

      it 'renders the json representation for the updated user' do
        expect(json_response[:users][:email]).to eql 'newmail@example.com'
      end

      it 'responds with 201' do
        expect(response.status).to eq 201
      end
    end

    context "when is not created" do
      before do
        @user = create :user
        api_authorization_header @user.auth_token
        patch :update, { id: @user.user_id,
                         users: { email: 'bademail.com' } }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        expect(json_response[:errors]).to include 'Email is invalid'
      end

      it 'responds with 422' do
        expect(response.status).to eq 422
      end
    end
  end
end
