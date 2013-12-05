# Database connection
require 'active_record'
require_relative "../lib/settings"

db = Settings.database
connection = {
  :adapter  => 'postgresql',
  :host     => db.host,
  :username => db.username,
  :database => db.database,
  :encoding => 'utf8'
}
connection.merge!({
  :password => db.password
}) if RACK_ENV != "production"

ActiveRecord::Base.establish_connection(connection)
