RACK_ENV = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require "rubygems"
require "bundler"


require 'active_record'
Bundler.setup
Bundler.require(:default, RACK_ENV.to_sym)

require 'sinatra'
require 'sinatra/base'
require "sinatra/json"
require 'squeel'
require 'sass/plugin/rack'
require 'redis'
require 'resque'
require 'github/markup'

require_relative 'database'

use Rack::Logger

Resque.redis = Redis.new

["app/models", "lib", "app/jobs"].each do |path|
  Dir.glob(File.join(RACK_ROOT, path, "/**/*.rb")).each do |file|
    require File.join(file)
  end
end

Mail.defaults do
  delivery_method :smtp, {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => 'eggandjam.com',
    :user_name => ENV["EMAILER_USERNAME"],
    :password => ENV["EMAILER_PASSWORD"],
    :authentication => 'plain',
    :enable_starttls_auto => true }

end

ActiveRecord::Base.logger = Logger.new("logs/queries.log")
