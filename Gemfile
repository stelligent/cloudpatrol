source 'https://rubygems.org'
ruby '2.3.8'

gem 'simplecov', :require => false, :group => :test

gem 'rails', '~> 4.2.11'
gem "cloudformation-ruby-dsl"
gem 'whenever', require: false

gem 'haml-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap-sass'

#gem 'cloudpatrol', '0.1.3'
gem 'cloudpatrol', git: 'https://github.com/stelligent/cloudpatrol_gem.git', branch: 'master', ref: 'HEAD'
#gem 'cloudpatrol', :path => '/Users/erickascic/github/cloudpatrol_gem'

gem 'bcrypt-ruby'
gem 'sqlite3'

group :doc do
  gem 'sdoc', require: false
end

group :test do
  gem 'capybara'
  gem 'watir'
end

group :test, :development do
  gem 'rspec-rails'
end
