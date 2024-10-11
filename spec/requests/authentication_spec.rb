# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123') }

  describe 'POST /auth/login' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post '/auth/login', params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns a 401 status' do
        post '/auth/login', params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
