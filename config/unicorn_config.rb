worker_processes 2

working_directory "/data/emailer/current" # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
#listen "/path/to/.unicorn.sock", :backlog => 64
listen (ENV["PORT"] || 3000), :tcp_nopush => true
#listen '/data/emailer/current/tmp/sockets/unicorn.sock', :backlog => 64

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

pid "/data/emailer/shared/tmp/pids/unicorn.pid"

preload_app true
stderr_path "/data/emailer/shared/logs/unicorn.stderr.log"
stdout_path "/data/emailer/shared/logs/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid_file = '/data/emailer/shared/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid_file) && server.pid != old_pid_file

    old_pid = File.read(old_pid_file).to_i

    begin
      puts "Killing PID #{old_pid}"
      Process.kill(:QUIT, old_pid)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end


after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  require "/data/emailer/current/config/database"
  #defined?(ActiveRecord::Base) and
    #ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end

