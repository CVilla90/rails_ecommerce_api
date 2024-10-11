# ecommerce_api/app/services/json_web_token.rb

# Handles encoding and decoding of JSON Web Tokens (JWT) for authentication
class JsonWebToken
  # Secret key used for encoding and decoding JWT tokens
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  # Encodes a payload into a JWT
  # @param payload [Hash] The data to encode in the JWT
  # @param exp [Time] The expiration time for the token (default: 24 hours from now)
  # @return [String] Encoded JWT token
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Decodes a JWT token
  # @param token [String] The JWT token to decode
  # @return [Hash] Decoded payload as a hash with indifferent access
  # @raise [ExceptionHandler::InvalidToken] If the token is invalid
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
