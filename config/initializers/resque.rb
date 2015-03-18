# Load the redis configuration from resque.yml
Resque.redis = "#{ENV['REDIS_PORT_6379_TCP_ADDR']}:#{ENV['REDIS_PORT_6379_TCP_PORT']}"
