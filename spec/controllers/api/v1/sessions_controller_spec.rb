require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:credentials) { { email: user.email, password: password } }

    before do
      post :create, { session: credentials }
    end

    context 'when credentials are correct' do
      let(:password) { '12345678' }

      it 'returns the authenticated user' do
        user.reload
        expect(json_response[:api_token]).to eq user.api_token
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
    let!(:api_token) { user.api_token }

    before do
      sign_in user
      delete :destroy, id: api_token
    end

    it 'returns no content' do
      expect(response.status).to eq 204
    end

    it 'invalidates the current api token' do
      expect(user.reload.api_token).not_to eq api_token
    end
  end
end
