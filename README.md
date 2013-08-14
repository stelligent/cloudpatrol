Stelligent CloudPatrol
==============

## Description

This app lets you establish and automatically enforce team policies for your Amazon Web Services account.
Clean installation has a superuser account with ```admin:admin``` credentials; be sure to change it after first login.

While Rails can be installed on many operating systems, we've include detailed instructions for installing on Ubuntu 12.04 LTS.

There's also a [Ruby gem](https://github.com/stelligent/cloudpatrol_gem) - for applying the rules via the command line - that you can download and use [here](https://github.com/stelligent/cloudpatrol_gem). For more information on creating new rules/tasks, see [Executing a Task/Rule in CloudPatrol Rails app](https://github.com/stelligent/cloudpatrol/blob/master/RAILS_CREATING_NEW_TASK.md).

## Configuration of Linux Instance

You'll need to first download and install Ubuntu 12.04 LTS. To do this, go to [Ubuntu](http://releases.ubuntu.com/precise/).


## Installing Rails on Ubuntu 12.04 LTS

After you've installed Ubunu, follow the instructions below.

1. ```sudo apt-get update```
1. ```sudo apt-get -y install curl nodejs git```
1. ```\curl -L https://get.rvm.io | bash -s stable```
1. ```source ~/.rvm/scripts/rvm```
1. ```rvm requirements```
1. ```rvm install 1.9.3```
1. ```rvm use 1.9.3 --default```
1. ```rvm rubygems current```
1. ```gem install rails```

## Installing CloudPatrol

Now that you've intalled Ruby and other packages, you will install CloudPatrol on this instance.

1. ```git clone https://github.com/stelligent/cloudpatrol.git```
1. ```cd ~/cloudpatrol```
1. ```bundle install```
1. ```bundle exec rake db:setup```
1. ```bundle exec rake db:test:prepare```
1. ```bundle exec rspec spec/```
1. ```rails s```


## Running CloudPatrol

1. Launch and web browser and type http://[hostname]:3000 (You will need to make sure that port 3000 is open)
1. Login to the application using the default credentials (```admin:admin```).

## LICENSE

Copyright (c) 2013 Stelligent Systems LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
