# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'john.doe@example.com', password: 'password123')
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(name: 'John Doe', password: 'password123')
    expect(user).not_to be_valid
  end

  # Add other examples as needed
end
