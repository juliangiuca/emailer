# Database connection
require 'active_record'
require_relative "../lib/settings"

connection = {
  :adapter  => 'postgresql',
  :encoding => 'utf8'
}

db = Settings.database
connection = db.to_hash.inject(connection) do |co, (key, value)|
  co[key] = value; co
end

ActiveRecord::Base.establish_connection(connection)
