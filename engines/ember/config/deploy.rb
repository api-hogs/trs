# config valid only for Capistrano 3.1
lock '3.4.0'
set :repo_url, 'git@github.com:api-hogs/trs.git'

set :application, "#{fetch(:stage)}-trs-app"
set :deploy_to,   "/var/www/#{fetch(:stage)}-trs-app"
# Default branch is :master
set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{engines/ember/node_modules engines/ember/bower_components}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{release_path}/engines/ember && npm install"
      execute "cd #{release_path}/engines/ember && bower install"
      execute "cd #{release_path}/engines/ember && ember build --environment #{fetch(:stage)}"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

    end
  end

end
