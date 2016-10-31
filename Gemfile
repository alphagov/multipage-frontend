source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "5.0.0.1"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0.4"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", group: :doc

gem 'airbrake', '~> 5.5'
gem 'airbrake-ruby', '1.5'
gem "gds-api-adapters", "26.6.0"
gem "govuk_frontend_toolkit", "2.0.1"
gem "logstasher", "0.6.2"
gem "plek", "1.11.0"
gem "slimmer", "9.6.0"
gem "unicorn", "5.0.1"
gem "htmlentities"

# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]

group :development, :test do
  gem "govuk-lint"
  gem "pry"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5"
  gem "simplecov", "0.10.0", require: false
  gem "simplecov-rcov", "0.2.3", require: false
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem "capybara", "2.5.0"
  gem "webmock", "1.21.0"
  gem 'govuk-content-schema-test-helpers'
  gem 'rails-controller-testing'
end
