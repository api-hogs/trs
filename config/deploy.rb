lock '3.4.0'

set :application, 'trs'
set :repo_url, 'git@github.com:api-hogs/trs.git'
set :deploy_to, "/var/www/trs-#{fetch(:stage)}"
set :default_env, {
                    'MIX_ENV' => fetch(:stage)
                }

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :phoenix_app, 'trs'
# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'deps', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/uploads')

namespace :deploy do
  task :get_deps do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, 'deps.get')
      end
    end
  end

  task :compile do
    on roles(:app) do |host|
      within(release_path) do
        execute(:touch, 'deps/plug/mix.exs')
        execute(:mix, 'deps.compile plug')
        execute(:mix, 'deps.compile')
      end
    end
  end

  task :create_db do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "ecto.create")
      end
    end
  end

  task :migrate do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "ecto.migrate")
      end
    end
  end

end

namespace :phoenix do
  def is_application_running?()
    pid = capture(%Q{ps ax -o pid= -o command=|grep "rel/#{fetch(:phoenix_app)}/.*/[b]eam"|awk '{print $1}'})
    return pid != ""
  end

  desc 'Build exrm release'
  task :build do
    on roles(:app) do
      within release_path do
        # execute "cd #{current_path}; yes | MIX_ENV=#{fetch(:stage)} /usr/bin/env mix deps.get"
        # execute "cd #{current_path}; yes | MIX_ENV=#{fetch(:stage)} /usr/bin/env mix release"
        execute :mix, "do deps.get, release"
      end
    end
  end

  task :restart do
    on roles(:app), in: :sequence do
      within current_path do
        if is_application_running?
          execute "rel/#{fetch(:phoenix_app)}/bin/#{fetch(:phoenix_app)}", "stop"
        end
        execute "rel/#{fetch(:phoenix_app)}/bin/#{fetch(:phoenix_app)}", "start"
      end
    end
  end
end

after 'deploy:updated', 'deploy:get_deps'
after 'deploy:updated', 'deploy:compile'

after 'deploy:updated', 'deploy:create_db'
after 'deploy:updated', 'deploy:migrate'

after 'deploy:published', 'phoenix:build'
after 'deploy:published', 'phoenix:restart'
