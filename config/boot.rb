require "rubygems"

RACK_ENV ||= ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT ||= File.expand_path(File.dirname(__FILE__) + '/..')

require "bundler"
Bundler.setup
#Bundler.require(:default, RACK_ENV.to_sym)

require_relative "./database"
require_relative "./email"
require_relative "./redis"


require 'sinatra'
require 'sinatra/base'
require 'sinatra/advanced_routes'
require "sinatra/json"
require 'sass/plugin/rack'
require 'newrelic_rpm'

#use Rack::Logger

#$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

["app/models", "lib", "app/jobs"].each do |path|
  #$LOAD_PATH.unshift File.join(RACK_ROOT, path)
  Dir.glob(File.join(RACK_ROOT, path, "/**/*.rb")).each do |file|
    require File.join(file)
  end
end
