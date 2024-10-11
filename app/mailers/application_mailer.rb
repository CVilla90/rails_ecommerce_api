# ecommerce_api\app\mailers\application_mailer.rb

# Base class for mailers in the application
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  # Application-wide settings for mailers
end
