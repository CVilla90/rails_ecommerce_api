# app/controllers/users_controller.rb

# Controller to handle user actions including authentication, registration, and recommendations.
class UsersController < ApplicationController
  include Authenticate
  before_action :set_user, only: [:show, :update, :destroy, :recommendations]
  skip_before_action :authenticate_request, only: [:create, :login]

  # @!group User Actions

  # POST /auth/login
  # Authenticate a user and generate a JWT token.
  # Parameters are passed via request body:
  #   - email: The email of the user.
  #   - password: The password of the user.
  # @return [JSON] The JWT token or unauthorized message.
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # POST /users
  # Register a new user.
  # Parameters are passed via request body:
  #   - name: The name of the user.
  #   - email: The email of the user.
  #   - password: The password of the user.
  # @return [JSON] The newly created user or validation errors.
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  # Fetch a user by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the user to retrieve.
  # @return [JSON] Details of the user.
  def show
    render json: @user
  end

  # PUT /users/:id
  # Update an existing user.
  # Parameters are passed via URL and request body:
  #   - id: The ID of the user to update.
  #   - name, email, password: Fields to update.
  # @return [JSON] The updated user or validation errors.
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  # Delete a user by ID.
  # Parameters are passed via URL:
  #   - id: The ID of the user to delete.
  # @return [NilClass] HTTP status 204 (No Content).
  def destroy
    @user.destroy
    head :no_content
  end

  # GET /users/:id/recommendations
  # Provide product recommendations based on previous purchases.
  # Parameters are passed via URL:
  #   - id: The ID of the user to get recommendations for.
  # @return [JSON] List of recommended products or a message indicating no recommendations are available.
  def recommendations
    purchased_products = @user.orders.pluck(:product_id)
    recommended_products = Product.where.not(id: purchased_products).limit(3)

    if recommended_products.any?
      render json: recommended_products, status: :ok
    else
      render json: { message: 'No recommendations available' }, status: :ok
    end
  end

  # @!endgroup

  private

  # Set the user instance based on ID.
  # This method is used as a before_action to retrieve the user from the database.
  # @return [User] The user object.
  def set_user
    @user = User.find(params[:id])
  end

  # Strong parameters for user creation and update.
  # This method is used to specify which parameters are allowed during user creation or update.
  # @return [ActionController::Parameters] The permitted user parameters.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
