set :application, "sharetaskboard"
set :repository,  "/usr/local/project/sharetaskboard/.git"
set :local_repository,  "/usr/local/project/sharetaskboard/.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_via,  :copy
set :deploy_to, "/usr/local/project/release/#{application}"
set :keep_releases,3

role :web, "127.0.0.1:22"                          # Your HTTP server, Apache/etc
role :app, "127.0.0.1:22"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :local do
  task :deploy do
    run "cp /usr/local/project/release"
  end
end

# If you are using Passenger mod_rails uncomment this:
#namespace :deploy do
#  task :start,:roles=> :app do
#    run "./script/start_local_server.sh"
#    run "cp /usr/local/project/release"
#    send(run_method,"./script/start_local_server.sh")
#  end
#  task :stop,:roles=>:app do
#    run "./script/stop_local_server.sh"
#  end
#  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end
#end
