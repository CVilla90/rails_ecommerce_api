# spec/requests/products_controller_spec.rb
require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  let(:valid_attributes) do
    {
      name: 'Valid Product',
      price: 150.0,
      description: 'This is a valid description.'
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,             # `name` should be present
      price: -10.0,          # `price` should be greater than 0
      description: ''        # `description` should be present
    }
  end

  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123') }
  let(:valid_headers) do
    post '/auth/login', params: { email: user.email, password: 'password123' }
    token = JSON.parse(response.body)['token']
    { 'Authorization' => "Bearer #{token}" }
  end

  describe 'POST /products' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post '/products', params: { product: valid_attributes }, headers: valid_headers
        }.to change(Product, :count).by(1)
      end

      it 'returns a 201 status' do
        post '/products', params: { product: valid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:created)
      end

      it 'returns the created product as JSON' do
        post '/products', params: { product: valid_attributes }, headers: valid_headers
        expect(response.media_type).to eq('application/json')
        expect(JSON.parse(response.body)['name']).to eq('Valid Product')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect {
          post '/products', params: { product: invalid_attributes }, headers: valid_headers
        }.not_to change(Product, :count)
      end

      it 'returns a 422 status' do
        post '/products', params: { product: invalid_attributes }, headers: valid_headers
        expect(response).to have_http_status(422)
      end

      it 'returns error messages as JSON' do
        post '/products', params: { product: invalid_attributes }, headers: valid_headers
        expect(response.media_type).to eq('application/json')
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end

    context 'without a valid token' do
      it 'returns a 401 unauthorized response' do
        post '/products', params: { product: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
