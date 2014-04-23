require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '10.7.1.17'
set :deploy_to, '/home/sarath/SENSAR/production'
set :repository, 'https://github.com/sharathkumar/sensar_app.git'
set :app_path,   "#{deploy_to}/#{current_path}"
set :branch, 'master'
set :term_mode, nil
# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log']

# Optional settings:
  set :user, 'sarath'    # Username in the server to SSH to.
# set :port, '2112'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-2.0.0-p451@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

task :seed => :environment do
  queue "bundle exec rake db:seed"
end

task :truncate => :environment do 
  queue "bundle exec rake db:truncate"
end

task :rails_console => :environment do
  queue "cd #{app_path}"
  queue "bundle exec rails c"
end

task :bundle=> :environment do
  queue "cd #{app_path}"
  queue "bundle install --system"
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle'
    invoke :'rails:db_migrate'
    #invoke :'truncate'
    invoke :'seed'
    invoke :'rails:assets_precompile'
  end
end

task :server => :environment do
  queue "echo '<-------Application restarting-------->'"
  queue "touch #{deploy_to}/tmp/restart.txt"
  queue "echo '<-------Application restarted--------->'"
end

task :restart do
  queue 'sudo service nginx restart'
end    


# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
