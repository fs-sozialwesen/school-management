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

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


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
