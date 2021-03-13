require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina_sidekiq/tasks'
require 'mina/whenever'
require 'mina/delayed_job'
# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'extend-interface'
set :domain, '82.179.84.219'
set :user, 'serveriot'
set :deploy_to, '/home/serveriot/extend-interface'
set :repository, 'git@github.com:Vchekryzhov/extends-operator-interface.git'
set :branch, 'master'
set :rails_env, 'production'
set :port, 2848

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  invoke :'rbenv:load'
end

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key')
set :shared_dir, fetch(:shared_files, []).push('public/uploads', 'tmp/pids')


# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %[mkdir -p "#{fetch(:deploy_to)}/shared/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log"]

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/pids/")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/pids")

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/pids"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/uploads"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/uploads"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/storage"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/storage"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  command %[touch "#{fetch(:deploy_to)}/shared/config/master.key"]
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'rbenv:load'
        # invoke :'delayed_job:restart'
        command %(RAILS_ENV=#{fetch(:rails_env)} bundle exec pumactl -F config/puma.rb stop)
        command %(RAILS_ENV=#{fetch(:rails_env)} bundle exec pumactl -F config/puma.rb start)
      end
    end
  end
end
