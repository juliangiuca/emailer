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

require_relative 'database'

use Rack::Logger
logger = Logger.new('logs/common.log','weekly')
logger.level = Logger::INFO

["app/models", "lib"].each do |path|
  Dir.glob(File.join(RACK_ROOT, path, "/**/*.rb")).each do |file|
    logger.info "Requiring #{file}"
    require File.join(file)
  end
end

require File.join(RACK_ROOT, "app", "app")
Emailer::Logger.logger = logger
