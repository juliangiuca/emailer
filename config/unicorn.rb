require 'dotenv'
Dotenv.load

# set path to app that will be used to configure unicorn, 
# note the trailing slash in this example
@dir = File.expand_path(File.join(__FILE__, "..", ".."))

worker_processes 2
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to, 
# we will use this in our nginx.conf later
#"#{@dir}/tmp/sockets/unicorn.sock", :backlog => 64
listen ENV['PORT'] || 3000

# Set process id path
pid "#{@dir}/tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}/logs/unicorn.stderr.log"
stdout_path "#{@dir}/logs/unicorn.stdout.log"
