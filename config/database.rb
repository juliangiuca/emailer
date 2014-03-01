# Database connection
require_relative "../lib/settings"

connection = {
  :encoding => 'utf8'
}

db = Settings.database
connection = db.to_hash.inject(connection) do |co, (key, value)|
  co[key] = value; co
end

