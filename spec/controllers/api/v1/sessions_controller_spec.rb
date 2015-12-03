require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:user)        { create :user }
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
end
