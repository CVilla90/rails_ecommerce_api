require 'rails_helper'
RSpec.describe UsersController, type: :request do
  let(:valid_attributes) do
    {
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      email: 'invalid_email',
      password: 'short',
      password_confirmation: 'mismatch'
    }
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post '/users', params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns a 201 status' do
        post '/users', params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
      end

      it 'returns the created user as JSON' do
        post '/users', params: { user: valid_attributes }
        expect(response.media_type).to eq('application/json')
        expect(JSON.parse(response.body)['name']).to eq('John Doe')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post '/users', params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'returns a 422 status' do
        post '/users', params: { user: invalid_attributes }
        expect(response).to have_http_status(422)
      end

      it 'returns error messages as JSON' do
        post '/users', params: { user: invalid_attributes }
        expect(response.media_type).to eq('application/json')
        expect(JSON.parse(response.body)).to have_key('password_confirmation')
      end
    end
  end
end