# app/controllers/orders_controller.rb

# Controller to handle CRUD operations for Orders.
class OrdersController < ApplicationController
  include Authenticate  # Protect this controller with JWT authentication
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  # Fetch all orders.
  # @return [JSON] List of all orders.
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/:id
  # Fetch a specific order by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the order to retrieve.
  # @return [JSON] Details of the specified order.
  def show
    render json: @order
  end

  # POST /orders
  # Create a new order.
  # Parameters are passed via request body:
  #   - user_id: The ID of the user creating the order.
  #   - product_id: The ID of the product being ordered.
  #   - quantity: The quantity of the product.
  #   - total_price: The total price of the order.
  # @return [JSON] The newly created order or validation errors.
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /orders/:id
  # Update an existing order.
  # Parameters are passed via URL and request body:
  #   - id: The ID of the order to update.
  #   - quantity, total_price: Fields to update.
  # @return [JSON] The updated order or validation errors.
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  # Delete an order by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the order to delete.
  # @return [NilClass] HTTP status 204 (No Content).
  def destroy
    @order.destroy
    head :no_content
  end

  private

  # Set the order instance based on ID.
  # This method is used as a before_action to retrieve the order from the database.
  # @return [Order] The order object.
  def set_order
    @order = Order.find(params[:id])
  end

  # Strong parameters for order creation and update.
  # This method is used to specify which parameters are allowed during order creation or update.
  # @return [ActionController::Parameters] The permitted order parameters.
  def order_params
    params.require(:order).permit(:user_id, :product_id, :quantity, :total_price)
  end
end
