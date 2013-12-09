set :application, 'emailer'
set :repo_url, 'git@github.com:juliangiuca/emailer.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

 set :deploy_to, '/data/emailer'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

 set :linked_files, %w{config/settings.json}
 set :linked_dirs, %w{bin logs tmp/pids tmp/cache tmp/sockets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      if test("[ -f #{shared_path}/tmp/pids/unicorn.pid ]")
        execute "cat #{shared_path}/tmp/pids/unicorn.pid"
        execute "kill -USR2 `cat #{shared_path}/tmp/pids/unicorn.pid`"
      else
        info "No unicorn process found"
      end
    end
  end

  task :pull_down_secret_files do
    on roles(:all) do
      execute "wget --user=#{ENV['BITBUCKET_USER']} --password='#{ENV['BITBUCKET_PASSWORD']}' -q -N https://bitbucket.org/localtoast/secret-files/raw/master/emailer/settings.production.json -O /data/emailer/shared/config/settings.json"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :started, 'deploy:pull_down_secret_files'

end
