set :application, 'emailer'
set :repo_url, 'git@github.com:juliangiuca/emailer.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

 set :deploy_to, '/data/emailer'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

 set :linked_files, %w{config/database.yml config/newrelic.yml .env}
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 3

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do

  desc 'Restart application'
  task :restart_unicorn do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      if test("[ -f #{shared_path}/tmp/pids/unicorn.pid ]")
        execute "kill -USR2 `cat #{shared_path}/tmp/pids/unicorn.pid`"
      else
        info "No unicorn process found"
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    invoke 'deploy:restart_unicorn'
    invoke 'deploy:restart_resque'
  end

  desc 'Restart resque'
  task :restart_resque do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      # Dir.glob(File.join(shared_path, "tmp", "pids", "resque-worker.*.pid")).each do |pid_file|
      #   execute "kill -QUIT `cat #{pid_file}`"
      # end

      bash=<<-BASH
        for f in #{shared_path}/tmp/pids/resque-worker.*.pid
        do kill -QUIT `cat $f`; true
        done
      BASH
      execute(bash)

    end
  end

  task :pull_down_secret_files do
    on roles(:all) do
      execute "mkdir -p /data/emailer/shared/config/"
      execute "wget --user=#{ENV['BITBUCKET_USER']} --password='#{ENV['BITBUCKET_PASSWORD']}' -q -N https://bitbucket.org/localtoast/secret-files/raw/master/emailer/database.yml -O /data/emailer/shared/config/database.yml"
      execute "wget --user=#{ENV['BITBUCKET_USER']} --password='#{ENV['BITBUCKET_PASSWORD']}' -q -N https://bitbucket.org/localtoast/secret-files/raw/master/emailer/dotenv -O /data/emailer/shared/.env"
      execute "wget --user=#{ENV['BITBUCKET_USER']} --password='#{ENV['BITBUCKET_PASSWORD']}' -q -N https://bitbucket.org/localtoast/secret-files/raw/master/emailer/newrelic.yml -O /data/emailer/shared/config/newrelic.yml"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
       within release_path do
        #  execute :rake, 'resque:stop'
       end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
  before :starting, 'deploy:pull_down_secret_files'

end
