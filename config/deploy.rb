set :application, "large scale application test"
set :repository,  "git://github.com/hlxwell/rails_app_logger.git"
set :scm, :git
set :keep_releases, 5
set :use_sudo, false

role :web, "115.238.44.110"
role :app, "115.238.44.110", "211.138.113.39", "211.138.113.63"
role :db, "115.238.44.110", :primary => true

set :user, "large_scale"
set :deploy_to, "/home/large_scale/app"
set :branch, "master"
set :rails_env, "production"
set :db_file, "mongoid.yml"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :init_project do
    run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle install"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:symlink", "deploy:init_project"
