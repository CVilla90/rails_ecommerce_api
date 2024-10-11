# ecommerce_api\app\models\order.rb

# Represents an order in the e-commerce application
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # @!attribute user_id
  #   @return [Integer] ID of the user associated with the order
  # @!attribute product_id
  #   @return [Integer] ID of the product associated with the order
  # @!attribute quantity
  #   @return [Integer] Quantity of the product ordered
  # @!attribute total_price
  #   @return [Decimal] Total price of the order
end
