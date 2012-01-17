# Make sure +bundle exec+ is used when executing rake tasks

job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task --silent :output"

every 15.minutes do
  rake "twitter:post"
end