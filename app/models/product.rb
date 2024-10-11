# ecommerce_api/app/models/product.rb

class Product < ApplicationRecord
    validates :name, presence: { message: "Name must be provided" }
    validates :price, presence: { message: "Price must be provided" }, numericality: { greater_than: 0, message: "Price must be greater than 0" }
    validates :description, presence: { message: "Description must be provided" }
  end
  