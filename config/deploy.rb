require 'bundler/capistrano'
require 'capistrano/confirm_branch'
require 'capistrano-unicorn'

set :application, "community"
set :repository,  "https://github.com/elm-city-craftworks/community.git"

set :deploy_to, "/home/deploy/community"
set :user, "deploy"

set :scm, :git
set :use_sudo, false
set :branch, $1 if `git branch` =~ /\* (\S+)\s/m
set :deploy_via, :remote_cache

server "community.practicingruby.com", :app, :web, :db, :primary => true

after 'deploy:update_code' do
  {"database.yml"      => "config/database.yml",
   # "twitter.yml"       => "config/twitter.yml",
   "omniauth.rb"       => "config/initializers/omniauth.rb",
   "secret_token.rb"   => "config/initializers/secret_token.rb",
   "mail.rb"           => "config/initializers/mail.rb"}.
  each do |from, to|
    run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
  end

  # run "ln -nfs /var/rapp/mail_whale/shared/mail_whale.store #{release_path}/db/newman.store"
end

after 'deploy:restart', 'unicorn:restart'
after "deploy", "deploy:migrate"
after "deploy", 'deploy:cleanup'

load 'deploy/assets'
