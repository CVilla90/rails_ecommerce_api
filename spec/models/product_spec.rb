# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = Product.new(name: 'Product', price: 100, description: 'Product Description')
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = Product.new(price: 100, description: 'Product Description')
    expect(product).not_to be_valid
  end

  # Add other examples as needed
end
