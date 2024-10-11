# ecommerce_api\spec\requests\orders_controller_spec.rb

require 'rails_helper'

RSpec.describe 'OrdersController', type: :request do
  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123') }
  let(:product) { Product.create(name: 'Sample Product', price: 50, description: 'Sample Description') }
  let(:valid_headers) do
    post '/auth/login', params: { email: user.email, password: 'password123' }
    token = JSON.parse(response.body)['token']
    { 'Authorization' => "Bearer #{token}" }
  end

  let(:valid_attributes) do
    {
      user_id: user.id,
      product_id: product.id,
      quantity: 2,
      total_price: 100.0
    }
  end

  let(:invalid_attributes) do
    {
      user_id: nil,
      product_id: nil,
      quantity: 0,
      total_price: -10.0
    }
  end

  describe 'GET /orders' do
    context 'with a valid token' do
      it 'returns a list of orders' do
        get '/orders', headers: valid_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without a token' do
      it 'returns a 401 unauthorized response' do
        get '/orders'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /orders/:id' do
    let!(:order) { Order.create(valid_attributes) }

    context 'with a valid token' do
      it 'returns the requested order' do
        get "/orders/#{order.id}", headers: valid_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(order.id)
      end
    end

    context 'without a token' do
      it 'returns a 401 unauthorized response' do
        get "/orders/#{order.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /orders' do
    context 'with valid parameters' do
      it 'creates a new Order' do
        expect {
          post '/orders', params: { order: valid_attributes }, headers: valid_headers
        }.to change(Order, :count).by(1)
      end

      it 'returns a 201 status' do
        post '/orders', params: { order: valid_attributes }, headers: valid_headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Order' do
        expect {
          post '/orders', params: { order: invalid_attributes }, headers: valid_headers
        }.not_to change(Order, :count)
      end

      it 'returns a 422 status' do
        post '/orders', params: { order: invalid_attributes }, headers: valid_headers
        expect(response).to have_http_status(422) # Changed from :unprocessable_entity to 422
      end
    end

    context 'without a valid token' do
      it 'returns a 401 unauthorized response' do
        post '/orders', params: { order: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /orders/:id' do
    let!(:order) { Order.create(valid_attributes) }
    let(:updated_attributes) { { quantity: 3, total_price: 150.0 } }

    context 'with valid parameters' do
      it 'updates the requested order' do
        put "/orders/#{order.id}", params: { order: updated_attributes }, headers: valid_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['quantity']).to eq(3)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the order' do
        put "/orders/#{order.id}", params: { order: invalid_attributes }, headers: valid_headers
        expect(response).to have_http_status(422) # Changed from :unprocessable_entity to 422
      end
    end
  end

  describe 'DELETE /orders/:id' do
    let!(:order) { Order.create(valid_attributes) }

    context 'with a valid token' do
      it 'deletes the order' do
        expect {
          delete "/orders/#{order.id}", headers: valid_headers
        }.to change(Order, :count).by(-1)
      end

      it 'returns a 204 no content status' do
        delete "/orders/#{order.id}", headers: valid_headers
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without a valid token' do
      it 'returns a 401 unauthorized response' do
        delete "/orders/#{order.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end