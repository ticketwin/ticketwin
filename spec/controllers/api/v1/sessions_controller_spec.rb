require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { create :user }
  let(:credentials) { { email: user.email, password: password } }

  describe 'POST #create' do
    before do
      post :create, { session: credentials }
    end

    context 'when credentials are correct' do
      let(:password) { '12345678' }

      it 'returns the authenticated user' do
        expect(json_response[:auth_token]).to eq user.reload.auth_token
      end
    end

    context 'when the credentials are invalid' do
      let(:password) { 'wrong_password' }

      it 'returns a json error' do
        expect(json_response[:errors]).to eq 'Invalid email or password'
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:auth_token) { user.reload.auth_token }
    let(:password) { '12345678' }

    before do
      post :create, { session: credentials }
      delete :destroy, id: auth_token
    end

    it 'returns no content' do
      expect(response.status).to eq 204
    end

    it 'invalidates the current api token' do
      expect(user.reload.auth_token).not_to eq auth_token
    end
  end
end
