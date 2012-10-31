require 'bundler/capistrano'

set :application, "CodingWays"
set :repository,  'https://github.com/codingways/codingways.git'
set :deploy_to, '/var/www/codingways.com'
set :scm, :git
set :deploy_via, :remote_cache
set :use_sudo, false
set :branch, 'master'

#/************ SERVER INFORMATION ********/
set :location, '10.8.0.1'
set :user, 'ubuntu'
ssh_options[:keys] = File.join(ENV["HOME"],".ssh","jpmermoz.pem")
role :web, location                          # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true # This is where Rails migrations will run
#/***************************************/

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

