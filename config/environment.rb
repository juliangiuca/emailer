require_relative 'boot'
require File.join(RACK_ROOT, "app", "app")

logger = Logger.new('log/emailer.log')
logger.level = Logger::INFO
Emailer::Logger.logger = logger
