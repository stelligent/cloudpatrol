source /usr/local/rvm/scripts/rvm
cd /cloudpatrol
bundle install --without development test doc
bundle exec rake db:migrate