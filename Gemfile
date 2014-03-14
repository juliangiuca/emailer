source 'https://rubygems.org'

gem 'sinatra', require: false
gem 'haml'
gem 'pg'
gem 'activerecord'
gem 'mail'
gem 'thin'
gem 'json'
gem 'active_model_serializers'
gem 'sinatra-contrib', require: false
gem 'sass'
gem 'annotate'
gem 'foreman'
gem "resque", "~> 2.0.0.pre.1", github: "resque/resque"
gem 'capistrano'
gem 'capistrano-bundler'
gem 'capistrano-rvm'
gem 'capistrano-rails'
gem 'newrelic_rpm'
gem 'factory_girl'
gem 'sinatra-advanced-routes', require: 'sinatra/advanced_routes'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv'
  gem 'rspec'
  gem 'database_cleaner'
end
