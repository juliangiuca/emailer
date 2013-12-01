require "rubygems"
require "bundler"

require 'dotenv'
Dotenv.load

RACK_ENV = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))


Bundler.setup
Bundler.require(:default, RACK_ENV.to_sym)

require_relative "database"


require 'sinatra'
require 'sinatra/base'
require "sinatra/json"
require 'sass/plugin/rack'
require 'redis'
require 'resque'


use Rack::Logger

uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://local@localhost:6379")
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = $redis

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

ActiveRecord::Base.logger = Logger.new(File.join(RACK_ROOT, "logs", "queries.log"))
