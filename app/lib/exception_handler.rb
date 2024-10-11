# ecommerce_api/app/lib/exception_handler.rb

# Handles cases of invalid tokens
module ExceptionHandler
  # Custom exception to handle situations where a JWT token is invalid.
  # This could be due to expiration, tampering, or other invalid data.
  class InvalidToken < StandardError
  end
end
