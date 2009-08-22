# For migrations
set :rails_env, 'production'

# Who are we?
set :application, 'quippo'
set :repository, "git@github.com:railsrumble/rr09-team-228.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "production"

# Where to deploy to?
role :web, "69.164.192.68"
role :app, "69.164.192.68"
role :db,  "69.164.192.68", :primary => true

# Deploy details
set :user, "deploy"
set :deploy_to, "/var/www/sites/u/apps/#{application}"
set :use_sudo, false
set :checkout, 'export'

before "deploy:setup", "db:password"

namespace :deploy do
  desc "Default deploy - updated to run migrations"
  task :default do
    set :migrate_target, :latest
    update_code
    migrate
    symlink
    restart
  end

  desc "Restart the mongrels"
  task :restart do
    send(run_method, "cd #{deploy_to}/#{current_dir} && touch tmp/restart.txt")
  end
  desc "Run this after every successful deployment" 
  task :after_default do
    cleanup
  end

  before :deploy do
    if real_revision.empty?
      raise "The tag, revision, or branch #{revision} does not exist."
    end
  end
end

namespace :db do
  desc "Create database password in shared path" 
  task :password do
    set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
    run "mkdir -p #{shared_path}/config" 
    put db_password, "#{shared_path}/config/dbpassword" 
  end
end
