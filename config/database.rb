# Database connection
require "active_record"
require_relative "../lib/settings"

db = Settings.database[RACK_ENV]
ActiveRecord::Base.establish_connection(db)



#ActiveRecord::Base.logger = Logger.new(File.join(RACK_ROOT, "logs", "queries.log"))
