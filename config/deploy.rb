# require 'capistrano/ext/multistage'

set :application, 'school-management'
set :repo_url, 'git@github.com:fs-sozialwesen/school-management.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :chruby_ruby, 'ruby-2.2.3'

set :deploy_to, '/var/www/school-management'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true
set :user, 'school_management_deploy'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# puma options with defaults
# set :puma_user, fetch(:user)
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
# for staging, needs to be adapted for production:
set :puma_bind, "tcp://0.0.0.0:9292"    #accept array for multi-bind
# set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_access.log"
# set :puma_error_log, "#{shared_path}/log/puma_error.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 16]
# set :puma_workers, 0
# set :puma_worker_timeout, nil
# set :puma_init_active_record, false
# set :puma_preload_app, true
# set :nginx_use_ssl, false
set :nginx_sites_available_path, "/etc/nginx/conf.d/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d/sites-enabled"


# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
      # execute :echo, '$(pwd)'
      # execute :echo, release_path
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
