# Ecommerce API - README

## Overview

This is a RESTful API for an e-commerce application built using Ruby on Rails. It includes endpoints to manage users, products, and orders. The API is secured with JWT-based authentication to ensure that only authenticated users can create, update, or delete resources.

### Features Implemented

- **API Design & Database**: Designed and documented the API with the required entities, including `Users`, `Products`, and `Orders`. The database used is PostgreSQL.
- **JWT Authentication**: Implemented JSON Web Token (JWT) authentication to secure the API endpoints. Only authenticated users can create, update, or delete resources.
- **CRUD Operations**: Implemented CRUD operations for `Users`, `Products`, and `Orders`. This allows creating, reading, updating, and deleting users, products, and orders.
- **Recommendations Feature**: Added a simple product recommendation feature for users, which suggests products based on their purchasing history.
- **RSpec Tests**: Added comprehensive RSpec tests to ensure the correct functioning of each endpoint and the validity of the data. Tests include:
  - **ProductsController**: Tests for creating products (both valid and invalid), status codes, and unauthorized access.
  - **OrdersController**: Tests for CRUD operations, status codes, and unauthorized access.
  - **UsersController**: Tests for user registration, login, CRUD operations, and product recommendations.
  - **Authentication**: Tests for JWT token generation and protected routes.
- **Code Quality**: Follows Rails conventions with clean and organized code. Proper use of concerns (e.g., `Authenticate` concern) and reusable methods.
- **API Documentation**: Documentation generated with YARD to provide detailed descriptions of each method and parameter for better developer support.

## Setup Instructions

### Prerequisites

- **Ruby**: 3.2 or newer
- **Rails**: 7.1 or newer
- **PostgreSQL**: Ensure PostgreSQL is installed and running

### Getting Started

1. **Clone the Repository**:

   ```sh
   git clone <repository-url>
   cd ecommerce_api
   ```

2. **Install Dependencies**:

   ```sh
   bundle install
   ```

3. **Database Setup**: Create, migrate, and seed the database:

   ```sh
   rails db:create db:migrate db:seed
   ```

4. **Environment Variables**: Set up the following environment variables for JWT authentication:

   - `SECRET_KEY_BASE`: Used for encoding JWT tokens. You can add these variables to `.env` or set them manually.

5. **Run the Server**:

   ```sh
   rails s
   ```

   The API should now be accessible at `http://localhost:3000`.

### Running Tests

To run the RSpec tests:

```sh
bundle exec rspec --format documentation
```

This will run all the tests with detailed output to easily see which tests pass or fail.

### Test Cases

The implemented RSpec test cases cover the following:

- **ProductsController**:
  - Creating a product with valid and invalid parameters.
  - Ensuring proper response codes (e.g., `201 Created`, `422 Unprocessable Entity`).
  - Testing authentication for protected routes.
- **OrdersController**:
  - Full CRUD operations for orders, with tests for correct responses and edge cases.
  - Validation of authentication and authorization.
- **UsersController**:
  - User registration, login, and CRUD operations.
  - Product recommendations for authenticated users.
- **Authentication**:
  - Testing JWT token generation.
  - Access control for protected routes.

## API Endpoints

### Authentication

- **POST /auth/login**: Authenticate a user and return a JWT token.

### Users

- **POST /users**: Create a new user.
- **GET /users/:id**: Retrieve a user by ID.
- **PUT /users/:id**: Update user information.
- **DELETE /users/:id**: Delete a user.
- **GET /users/:id/recommendations**: Retrieve product recommendations for a user.

### Products

- **GET /products**: Retrieve a list of all products.
- **GET /products/:id**: Retrieve a specific product by ID.
- **POST /products**: Create a new product (authentication required).
- **PUT /products/:id**: Update a product (authentication required).
- **DELETE /products/:id**: Delete a product (authentication required).

### Orders

- **GET /orders**: Retrieve a list of all orders (authentication required).
- **GET /orders/:id**: Retrieve a specific order by ID (authentication required).
- **POST /orders**: Create a new order (authentication required).
- **PUT /orders/:id**: Update an existing order (authentication required).
- **DELETE /orders/:id**: Delete an order (authentication required).

## Product Recommendation Feature

### Simple Approach (Implemented)

The product recommendation feature has been implemented using a simple approach based on user history:

- When a user requests product recommendations, the system first gathers all the products that the user has purchased in the past.
- The recommended products are selected from the set of products that the user has **not** purchased yet.
- This approach helps in suggesting new products to users, avoiding recommending items they already own.
- The implementation is lightweight and provides a basic recommendation without using machine learning.

### Machine Learning Approach (Summary)

As a bonus, we considered an approach using machine learning to provide more personalized recommendations:

- **User Behavior Analysis**: We could use collaborative filtering, which analyzes patterns in user behavior, such as purchase history, browsing history, or ratings, to recommend products that similar users have purchased.
- **Content-Based Filtering**: Alternatively, we could use content-based filtering by analyzing the features of products that the user likes and recommending similar items.
- **Implementation Time**: Implementing a machine learning-based recommendation system would require more effort, typically 1-2 weeks depending on the level of personalization, data preparation, and model training required.

For now, we opted for a simpler approach due to its ease of implementation and adequacy for basic product recommendations.

## Example Requests

### Creating a Product

- **Endpoint**: `POST /products`
- **Headers**: `Authorization: Bearer <JWT Token>`
- **Body**:

  ```json
  {
    "product": {
      "name": "Product Name",
      "price": 100.0,
      "description": "Product Description"
    }
  }
  ```

## Notes

- Only authenticated users can create, update, or delete products and orders.
- Proper error messages are returned for invalid inputs and unauthorized access.
- The project was developed and delivered by Carlos Villa on 10/10/2024.
- The project was completed in a two-day timeframe, which influenced the decision to use a simpler product recommendation approach instead of implementing a machine learning solution.

## Future Enhancements

- **Advanced Product Recommendations**: Implement a more advanced recommendation system using machine learning techniques to personalize suggestions.
- **Deploy to Production**: Deploy the application on a cloud platform such as Heroku or AWS.
- **Swagger Integration**: Integrate Swagger for easy exploration and testing of API endpoints.

## Documentation

- **YARD Documentation**: The API is documented using YARD. To generate the documentation, run:

  ```sh
  yard doc
  ```

  To view the documentation, open the `doc/index.html` file in your browser.

---

Feel free to explore and contribute to this project by adding more features or enhancing the existing ones!
