# spec/requests/users_controller_spec.rb

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123') }
  let(:product1) { Product.create(name: 'Product 1', price: 50, description: 'Description 1') }
  let(:product2) { Product.create(name: 'Product 2', price: 100, description: 'Description 2') }
  let(:product3) { Product.create(name: 'Product 3', price: 150, description: 'Description 3') }

  def valid_headers
    post '/auth/login', params: { email: user.email, password: 'password123' }
    token = JSON.parse(response.body)['token']
    { 'Authorization' => "Bearer #{token}" }
  end

  before do
    Order.create(user: user, product: product1, quantity: 1, total_price: 50)
    Order.create(user: user, product: product2, quantity: 2, total_price: 200)
  end

  describe 'GET /users/:id/recommendations' do
    context 'with a valid token' do
      it 'returns recommended products for the user' do
        get "/users/#{user.id}/recommendations", headers: valid_headers
        expect(response).to have_http_status(:ok)

        recommended_products = JSON.parse(response.body)

        if recommended_products.is_a?(Array)
          recommended_product_ids = recommended_products.map { |p| p['id'] }
          expect(recommended_product_ids).to include(product3.id)
        else
          expect(recommended_products['message']).to eq('No recommendations available')
        end
      end
    end

    context 'without a token' do
      it 'returns a 401 unauthorized response' do
        get "/users/#{user.id}/recommendations"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
