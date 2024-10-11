# ecommerce_api\app\models\application_record.rb

# Base class for all models in the application
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # All models inherit from this base class
end
