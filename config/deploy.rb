set :application, "CodingWays"
set :repository,  'https://github.com/codingways/codingways.git'
set :deploy_to, '/var/www/codingways.com'

set :scm, :git
set :user, 'usuario'
set :deploy_via, :remote_cache
set :use_sudo, false
set :branch, 'master'

role :web, "codingways.com"                          # Your HTTP server, Apache/etc
role :app, "codingways.com"                          # This may be the same as your `Web` server
role :db,  "codingways.com", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  # desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
