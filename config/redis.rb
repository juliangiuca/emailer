require 'redis'
require 'resque'
require_relative "../lib/settings"

redis = Redis.new(Settings.redis[RACK_ENV])
Resque.redis = redis


