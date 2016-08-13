# require 'capistrano/ext/multistage'

set :application, 'school'
set :repo_url, 'git@github.com:fs-sozialwesen/school-management.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :chruby_ruby, 'ruby-2.3.1'

# set :deploy_to, '/var/www/school-management'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true
# set :user, 'school_deploy'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :linked_files, %w{config/database.yml config/environment_variables.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db/seeds}

# puma options with defaults
# set :puma_user, fetch(:user)
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}ngin/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
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
set :nginx_config_name, 'school'
set :nginx_conf, -> { "#{shared_path}/nginx_#{fetch(:nginx_config_name)}.conf" }
# set :nginx_use_ssl, false
set :nginx_use_ssl, true

set :rollbar_token, ENV['ROLLBAR_TOKEN']
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5
