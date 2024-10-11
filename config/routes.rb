# ecommerce_api/config/routes.rb

Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication route
  post '/auth/login', to: 'users#login'

  # User CRUD routes, including recommendations
  resources :users, only: [:create, :show, :update, :destroy] do
    member do
      get 'recommendations'
    end
  end

  # Products and Orders CRUD routes
  resources :products
  resources :orders
end
