# Database connection
require 'active_record'
require_relative "../lib/settings"

db = Settings.database

ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => db.host,
  :username => db.username,
  :password => db.password,
  :database => db.database,
  :encoding => 'utf8'
)
