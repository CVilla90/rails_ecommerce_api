# ecommerce_api\app\channels\application_cable\channel.rb

# Channel for handling WebSocket connection streams in Rails
module ApplicationCable
  # The base class for all channels in the application.
  # This class allows real-time features using WebSocket streams.
  class Channel < ActionCable::Channel::Base
  end
end