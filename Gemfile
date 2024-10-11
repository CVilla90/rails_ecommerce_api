source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.4"
gem "pg", "~> 1.1" # PostgreSQL database
gem "puma", ">= 5.0" # Puma web server
gem "bcrypt", "~> 3.1.7" # Password hashing for User authentication

# Caching improvements
gem "bootsnap", require: false

# JSON Web Tokens (JWT) for API authentication
gem "jwt"

# Testing framework
gem "rspec-rails", '~> 5.0.0'

# Documentation tool
gem "yard" # RubyDoc documentation

# Windows-specific timezone support
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ] # Debugging tool
end

group :development do
  # Speed up development commands (optional)
  # gem "spring"
end
