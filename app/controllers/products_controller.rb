# app/controllers/products_controller.rb

# Controller to handle CRUD operations for Products.
class ProductsController < ApplicationController
  include Authenticate  # Protect this controller with JWT authentication
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  # Fetch all products.
  # @return [JSON] List of all products.
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/:id
  # Fetch a specific product by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the product to retrieve.
  # @return [JSON] Details of the specified product.
  def show
    render json: @product
  end

  # POST /products
  # Create a new product.
  # Parameters are passed via request body:
  #   - name: The name of the product.
  #   - price: The price of the product.
  #   - description: The description of the product.
  # @return [JSON] The newly created product or validation errors.
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /products/:id
  # Update an existing product.
  # Parameters are passed via URL and request body:
  #   - id: The ID of the product to update.
  #   - name, price, description: Fields to update.
  # @return [JSON] The updated product or validation errors.
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  # Delete a product by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the product to delete.
  # @return [NilClass] HTTP status 204 (No Content).
  def destroy
    @product.destroy
    head :no_content
  end

  private

  # Set the product instance based on ID.
  # This method is used as a before_action to retrieve the product from the database.
  # @return [Product] The product object.
  def set_product
    @product = Product.find(params[:id])
  end

  # Strong parameters for product creation and update.
  # This method is used to specify which parameters are allowed during product creation or update.
  # @return [ActionController::Parameters] The permitted product parameters.
  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
