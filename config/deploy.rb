`ssh-add`

# For migrations
set :rails_env, 'production'

# Who are we?
set :application, 'quippo'
set :repository, "git@github.com:railsrumble/rr09-team-228.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "master"

set :ssh_options, { :forward_agent => true }

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
after "deploy:update_code", "deploy:gems"

namespace :deploy do

  desc "Start the Tracker"
  task :start do
    send(run_method, "cd #{deploy_to}/#{current_dir} && RAILS_ENV=#{rails_env} script/tracker start")
  end
  
  desc "Stop the Tracker"
  task :stop do
    send(run_method, "cd #{deploy_to}/#{current_dir} && RAILS_ENV=#{rails_env} script/tracker stop")
  end

  desc "Restart Rails & Tracker"
  task :restart do
    send(run_method, "cd #{deploy_to}/#{current_dir} && touch tmp/restart.txt")
    send(run_method, "cd #{deploy_to}/#{current_dir} && RAILS_ENV=#{rails_env} script/tracker restart")
  end
  
  desc "Run this after every successful deployment" 
  task :after_default do
    cleanup
  end
  
  desc "Install Gems"
  task :gems do
    sudo "rake -f #{release_path}/Rakefile gems:install", :pty => true
    sudo "rake -f #{release_path}/Rakefile gems:build", :pty => true
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

namespace :twitter do
  desc "Create Twitter login config"
  task :generate_config do
    set :twitter_login, Proc.new { Capistrano::CLI.password_prompt("Twitter screen name: ") }
    set :twitter_password, Proc.new { Capistrano::CLI.password_prompt("Twitter password: ") }
    run "mkdir -p #{shared_path}/config"
    put YAML.dump('login' => twitter_login, 'password' => twitter_password), "#{shared_path}/config/twitter_api.yml"
  end
end
