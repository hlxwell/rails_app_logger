set :application, "large scale application test"
set :repository,  "git://github.com/hlxwell/rails_app_logger.git"
set :scm, :git
set :keep_releases, 5
set :use_sudo, false

role :web, "211.138.113.39"
role :app, "211.138.113.39", "211.138.113.63", "115.238.44.110"
role :db, "211.138.113.39", :primary => true

set :user, "large_scale"
set :deploy_to, "/home/large_scale/app"
set :branch, "master"
set :rails_env, "production"
set :db_file, "mongoid.yml"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :init_project do
    # run "cd #{release_path}; /home/large_scale/.rvm/gems/ree-1.8.7-2011.03/bin/bundle install"
    run "cd #{release_path}; cp #{shared_path}/mongoid.yml #{release_path}/config/mongoid.yml"
  end

  # unicorn scripts cribbed from https://github.com/daemon/capistrano-recipes/blob/master/lib/recipes/unicorn.rb
  desc "Restart unicorn"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`" do |ch, stream, out|
      # is this block necessary?
    end
  end

  task :stop, :roles => :app do
    run "kill -QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`" do |ch, stream, out|
      # is this block necessary?
    end
  end

  task :start, :roles => :app do
    run "unicorn -E #{rails_env} -D -c #{current_path}/config/system/unicorn/production.rb" do |ch, stream, out|
      # is this block necessary?
    end
  end

  namespace :unicorn do
    [["TTIN", :add_worker, "Increase the Unicorn worker count by one"],
     ["TTOU", :remove_worker, "Decrease the Unicorn worker count by one"],
    ].each do |signal, task_name, description|
      desc description
      task task_name, :roles => :app do
        run "kill -#{signal} `cat /home/app/app/shared/pids/unicorn.pid`"
      end
    end
  end
end

namespace :nginx do
  desc "Reload nginx config files without restarting"
  task :reload, :roles => :web do
    sudo "/etc/init.d/nginx reload"
  end

  desc "Start"
  task :start, :roles => :web do
    sudo "/etc/init.d/nginx start"
  end

  desc "Kill nginx"
  task :stop, :roles => :web do
    # sudo "/etc/init.d/nginx stop"
    sudo "pkill -9 nginx"
  end

  desc "Restart nginx"
  task :restart, :roles => :web do
    nginx.stop
    nginx.start
  end
end

desc "Double-check that local revision is same as remote"
task "check_revisions" do
  remote = real_revision
  local = `git log #{branch} --format="format:%H" -n 1`.strip

  exit unless remote == local or
    Capistrano::CLI.ui.agree "local #{branch} is at #{local}...\nbut remote #{branch} is at #{remote}.\nAre you sure you want to deploy #{remote}? "
end

before "deploy", "check_revisions"
before "deploy:symlink", "deploy:init_project"