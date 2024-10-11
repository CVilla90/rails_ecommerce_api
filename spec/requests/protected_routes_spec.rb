# spec/requests/protected_routes_spec.rb

require 'rails_helper'

RSpec.describe 'Accessing Protected Routes', type: :request do
  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123') }
  let(:valid_headers) do
    post '/auth/login', params: { email: user.email, password: 'password123' }
    token = JSON.parse(response.body)['token']
    { 'Authorization' => "Bearer #{token}" }
  end

  describe 'GET /products (protected route)' do
    context 'without a token' do
      it 'returns a 401 unauthorized response' do
        get '/products'
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Not Authorized')
      end
    end

    context 'with an invalid token' do
      it 'returns a 401 unauthorized response' do
        get '/products', headers: { 'Authorization' => 'Bearer invalidtoken' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid token')
      end
    end

    context 'with a valid token' do
      it 'returns a list of products' do
        get '/products', headers: valid_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to be_a(Array) # Assuming it returns an array of products
      end
    end
  end
end
