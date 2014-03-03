require_relative "config/boot"
require 'resque/tasks'
load "active_record/railties/databases.rake"

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

#namespace :db do
  #desc "Run database migrations"
  #task :migrate, :env do |cmd, args|
    #env = args[:env] || "development"
    #Rake::Task['environment'].invoke(env)

    #require 'sequel/extensions/migration'
    #Sequel::Migrator.apply(Emailer::Database, "db/migrate")
  #end

  #desc "Rollback the database"
  #task :rollback, :env do |cmd, args|
    #env = args[:env] || "development"
    #Rake::Task['environment'].invoke(env)

    #require 'sequel/extensions/migration'
    #version = (row = Emailer::Database[:schema_info].first) ? row[:version] : nil
    #Sequel::Migrator.apply(Emailer::Database, "db/migrate", version - 1)
  #end

  #desc "Nuke the database (drop all tables)"
  #task :nuke, :env do |cmd, args|
    #env = args[:env] || "development"
    #Rake::Task['environment'].invoke(env)
    #Emailer::Database.tables.each do |table|
      #Emailer::Database.run("DROP TABLE #{table}")
    #end
  #end
#end

#namespace :resque do
  #desc "Quit running Resque workers"
  #task :stop do
    #current_path = File.expand_path(File.dirname(__FILE__))
    #Dir.glob(File.join(current_path, "tmp", "pids", "*.pid")).each do |pid_file|
      #pid = File.read(pid_file).strip
      #puts "Killing resque worker with PID of #{pid}"
      #`kill -QUIT #{pid}`
      #`rm #{pid_file}`
    #end
  #end
#end


dbt = ActiveRecord::Tasks::DatabaseTasks
dbt.env                    = RACK_ENV
dbt.db_dir                 = File.join(RACK_ROOT, "db")
dbt.fixtures_path          = File.join(RACK_ROOT, "spec", "fixtures")
dbt.migrations_paths       = [File.join(RACK_ROOT, "db", "migrations")]
dbt.root                   = RACK_ROOT

dbt.database_configuration = Settings.database

task :environment do
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  require File.expand_path(File.join(*%w[ config env ]), File.dirname(__FILE__))

end
