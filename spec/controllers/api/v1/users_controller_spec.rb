require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    before do
      @user = create :user
      api_authorization_header @user.auth_token
      get :show, id: @user.user_id
    end

    it 'returns the information about a reporter on a hash' do
      expect(json_response[:users][:email]).to eql @user.email
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        @user_attributes = attributes_for :user
        post :create, { users: @user_attributes }
      end

      it 'renders the json representation for the user record just created' do
        expect(json_response[:users][:email]).to eql @user_attributes[:email]
      end

      it 'responds with 201' do
        expect(response.status).to eq 201
      end
    end

    context 'when is not created' do
      before do
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { users: @invalid_user_attributes }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        expect(json_response[:errors][:email]).to include "can't be blank"
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
        expect(json_response[:errors][:email]).to include 'is invalid'
      end

      it 'responds with 422' do
        expect(response.status).to eq 422
      end
    end
  end
end
