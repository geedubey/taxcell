
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion

#role :app, "your app-server here"
#role :web, "your web-server here"
#role :db,  "your db-server here", :primary => true

default_run_options[:pty] = true

# be sure to change these
set :user, "gdubey"
set :domain, "tryme.deepakpant.com"
set :application, "ITR2009"

# the rest should be good
set :repository,  "http://svn.deepakpant.com/synv1/ITR2009"
set :deploy_to, "/home/#{user}/#{domain}" 
set :deploy_via, :remote_cache

set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  task :restart do
  	#environ .rb manipulation
  	run "rm #{current_path}/config/environment.rb"
  	run "mv #{current_path}/config/deploy-environment.rb #{current_path}/config/environment.rb"
  	run "rm #{current_path}/config/environments/development.rb"
  	run "mv #{current_path}/config/environments/deploy-development.rb #{current_path}/config/environments/development.rb"
    run "touch #{current_path}/tmp/restart.txt" 
  end
end
