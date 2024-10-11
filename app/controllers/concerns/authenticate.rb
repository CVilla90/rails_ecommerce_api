# app/controllers/concerns/authenticate.rb

module Authenticate
  extend ActiveSupport::Concern

  included do
    # Ensure the request is authenticated before executing any actions
    before_action :authenticate_request
  end

  private

  def authenticate_request
    # Extract the JWT token from the Authorization header
    header = request.headers['Authorization']
    if header.blank?
      render json: { error: 'Not Authorized' }, status: :unauthorized
      return
    end

    token = header.split(' ').last

    begin
      decoded_token = JsonWebToken.decode(token)
      @current_user = User.find(decoded_token[:user_id])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    rescue JWT::ExpiredSignature
      render json: { error: 'Token has expired' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    rescue StandardError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
