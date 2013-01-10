set :application, "wp"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# --------------------------------------------
# Define required Gems/libraries
# --------------------------------------------
# require 'ash/wordpress'

# multistage
set :stages, %w(production development staging)
set :default_stage, "development"
require 'capistrano/ext/multistage'

set :user, "vagrant"
set :group, "vagrant"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# VCS information.
set :scm, :git
set :repository, "vagrant@192.168.33.12:/home/#{user}/#{application}.git"
# set :deploy_via, :remote_cache

# SSH login credentials
set :user, "vagrant"
set :group, "vagrant"

# Deploy to = file path where the application will reside
set(:deploy_to) { "/home/#{user}/#{application}/#{stage}" }

# --------------------------------------------
# Database + File Backup Variables
# --------------------------------------------
# Database credentials
set :dbuser, "vagrant"

# Set Excluded directories/files (relative to the application's root path)
set(:backup_exclude) { [ "wp-content/cache" ] }

# --------------------------------------------
# Application Specific Methods
# --------------------------------------------
namespace :app do
  desc "Removes any additional unnecessary files or directories after deploy:finalize_update"
  task :finalize_update, :except => { :no_release => true } do
    logger.debug "Removing additional files"
    run "rm -Rf #{latest_release}/htaccess.dist"
    run "rm -rf #{latest_release}/wp-config-sample.php"
  end
end

# --------------------------------------------
# Callbacks
# --------------------------------------------
# before "deploy:update_code", "deploy:setup_backup"
# after "deploy:setup_backup", "backup"
after "deploy:finalize_update", "app:finalize_update"