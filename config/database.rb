# Database connection
db = URI.parse(ENV['HEROKU_POSTGRESQL_GRAY_URL'] || 'postgres://local:@localhost/emailer_development')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)
