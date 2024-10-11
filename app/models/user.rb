# ecommerce_api/app/models/user.rb

class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_secure_password

  # Add other validations as necessary
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
