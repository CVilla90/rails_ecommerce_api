# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123')
    product = Product.create(name: 'Product', price: 50, description: 'Description')
    order = Order.new(user: user, product: product, quantity: 1, total_price: 50)

    expect(order).to be_valid
  end

  it 'is not valid without a user' do
    product = Product.create(name: 'Product', price: 50, description: 'Description')
    order = Order.new(product: product, quantity: 1, total_price: 50)

    expect(order).not_to be_valid
  end

  # Add other examples as needed
end
