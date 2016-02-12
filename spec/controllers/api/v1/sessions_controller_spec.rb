require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { create :user }
  let(:credentials) { { email: email, password: password } }

  describe 'POST #create' do
    before do
      post :create, { sessions: credentials }
    end

    context 'when credentials are correct' do
      let(:email)    { user.email }
      let(:password) { '12345678' }

      it 'returns the authenticated user' do
        expect(json_response[:users][:auth_token]).to eq user.reload.auth_token
      end
    end

    context 'when the password is invalid' do
      let(:email)    { user.email }
      let(:password) { 'wrong_password' }

      it 'returns a json error' do
        expect(json_response[:errors]).to eq 'Invalid email or password'
        expect(response.status).to eq 422
      end
    end

    context 'when the email is invalid' do
      let(:email)    { 'not-a-valid-email' }
      let(:password) { '12345678' }

      it 'returns a json error' do
        expect(json_response[:errors]).to eq 'Invalid email or password'
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:auth_token) { user.reload.auth_token }
    let(:email)      { user.email }
    let(:password)   { '12345678' }

    before do
      post :create, { sessions: credentials }
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
