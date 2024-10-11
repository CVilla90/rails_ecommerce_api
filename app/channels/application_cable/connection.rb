# ecommerce_api\app\channels\application_cable\connection.rb

# Establishes a WebSocket connection with the server
module ApplicationCable
  # Handles authentication and identification of the WebSocket connection.
  # Every new WebSocket connection starts here.
  class Connection < ActionCable::Connection::Base
  end
end
