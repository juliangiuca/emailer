namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => [:environment] do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths, step)
  end

  namespace :create do
    task :all => :environment do
      ActiveRecord::Tasks::DatabaseTasks.create_all
    end
  end

  desc 'Create the database from DATABASE_URL or config/database.yml for the current Rails.env (use db:create:all to create all databases in the config)'
  task :create => [:environment] do
    if ENV['DATABASE_URL']
      ActiveRecord::Tasks::DatabaseTasks.create_database_url
    else
      ActiveRecord::Tasks::DatabaseTasks.create_current
    end
  end

  namespace :drop do
    task :all => :environment do
      ActiveRecord::Tasks::DatabaseTasks.drop_all
    end
  end

  desc 'Drops the database using DATABASE_URL or the current Rails.env (use db:drop:all to drop all databases)'
  task :drop => [:environment] do
    if ENV['DATABASE_URL']
      ActiveRecord::Tasks::DatabaseTasks.drop_database_url
    else
      ActiveRecord::Tasks::DatabaseTasks.drop_current
    end
  end
end

task :environment do
  require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))
end
