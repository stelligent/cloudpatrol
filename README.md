cloudpatrol
===========

### Sensitive data

These files must be created manually and never committed to the repository (they are in .gitignore already).

##### 1. ```config/aws.yml```

Contains AWS credentials. Example:

```
common: &common
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
test:
  <<: *common
development:
  <<: *common
production:
  <<: *common
```

or, if you want to use different credentials for Rails environments:

```
test:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
development:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
production:
  access_key_id: <YOUR_AWS_ACCESS_KEY_ID>
  secret_access_key: <YOUR_AWS_SECRET_ACCESS_KEY>
```


CloudPatrol
==============

## Description

This app lets you establish and automatically enforce team policies for your Amazon Web Services account.
Clean installation has a superuser account with ```admin:admin``` credentials; be sure to change it after first login.

While Rails can be installed on many operating systems, we've include detailed instructions for installing on Ubuntu 12.04 LTS.

## Configuration of Linux Instance

You'll need to first download and install Ubuntu 12.04 LTS. To do this, go to [Ubuntu](http://releases.ubuntu.com/precise/). 


## Installation of Rails on Ubuntu 12.04 LTS

After you've installed Ubunu, follow the instructions below (which were adpated from [digitalocean](https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm))

1. ```sudo apt-get update```
1. ```sudo apt-get install curl```
1. ```\curl -L https://get.rvm.io | bash -s stable```
1. ```source ~/.rvm/scripts/rvm```
1. ```rvm requirements```
1. ```rvm install 2.0.0```
1. ```rvm use 2.0.0 --default```
1. ```rvm rubygems current```
1. ```gem install rails```
1. ```sudo apt-get install nodejs```
1. ```sudo apt-get install git```

## Installation of CloudPatrol

Now that you've intalled Ruby and other packages, you will install CloudPatrol on this instance.

1. ```git clone https://github.com/stelligent/cloudpatrol.git```
1. ```cd cloudpatrol```
1. ```bundle install```
1. ```bundle exec rake db:setup```
1. ```bundle exec rake db:test:prepare```
1. ```bundle exec rspec spec/```
1. ```rails s``` 
