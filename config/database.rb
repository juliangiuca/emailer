ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host => "localhost",
  :username => "local",
  :password => "",
  :database => "emailer_development"
)
