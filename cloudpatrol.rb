#!/usr/bin/env ruby

require 'bundler/setup'
require 'cloudformation-ruby-dsl/cfntemplate'
require 'cloudformation-ruby-dsl/spotprice'
require 'cloudformation-ruby-dsl/table'

template do

  value :AWSTemplateFormatVersion => '2010-09-09'

  value :Description => 'AWS CloudFormation Template to run CloudPatrol'

  parameter 'KeyName',
            :Description => 'Name of an existing EC2 KeyPair to enable SSH access to the instance',
            :Type => 'String'

  parameter 'sha1',
            :Default => 'master',
            :Description => 'sha1 or branch HEAD to checkout',
            :Type => 'String'

  parameter 'InstanceType',
            :Description => 'EC2 instance type',
            :Type => 'String',
            :Default => 'c3.large',
            :ConstraintDescription => 'must be a valid EC2 instance type.'

  mapping 'RegionMap',
          :'us-east-1' => { :AMI => 'ami-05355a6c' },
          :'us-west-1' => { :AMI => 'ami-951945d0' },
          :'us-west-2' => { :AMI => 'ami-16fd7026' },
          :'eu-west-1' => { :AMI => 'ami-24506250' },
          :'sa-east-1' => { :AMI => 'ami-3e3be423' },
          :'ap-southeast-1' => { :AMI => 'ami-74dda626' },
          :'ap-northeast-1' => { :AMI => 'ami-dcfa4edd' }

  resource 'User', :Type => 'AWS::IAM::User', :Properties => {
      :Path => '/',
      :Policies => [
          {
              :PolicyName => 'root',
              :PolicyDocument => {
                  :Statement => [
                      { :Effect => 'Allow', :Action => '*', :Resource => '*' },
                  ],
              },
          },
      ],
  }

  resource 'HostKeys', :Type => 'AWS::IAM::AccessKey', :Properties => { :UserName => ref('User') }

  resource 'Ec2Instance', :Type => 'AWS::EC2::Instance', :Metadata => { :'AWS::CloudFormation::Init' => { :config => { :packages => { :rubygems => { :bundler => [] }, :yum => { :'gcc-c++' => [], :autoconf => [], :automake => [], :'libxml2-devel' => [], :'libxslt-devel' => [], :git => [], :'sqlite-devel' => [], :make => [] } }, :services => { :sysvinit => { :railsd => { :enabled => 'true', :ensureRunning => 'true' } } }, :files => { :'/etc/chef/solo.rb' => { :content => join('', "log_level :info\n", "log_location STDOUT\n", "file_cache_path \"/var/chef-solo\"\n", "cookbook_path \"/var/chef-solo/cookbooks\"\n"), :mode => '000644', :owner => 'root', :group => 'root' }, :'/etc/chef/node.json' => { :content => join('', ''), :mode => '000644', :owner => 'root', :group => 'root' }, :'/root/.gemrc' => { :content => join('', 'gem: --no-ri --no-rdoc') }, :'/etc/gemrc' => { :content => join('', 'gem: --no-ri --no-rdoc') }, :'/etc/init.d/railsd' => { :mode => '000544', :content => join('', "#! /bin/sh\n", "### BEGIN INIT INFO\n", "# Default-Start:     2 3 4 5\n", "# Default-Stop:      0 1 6\n", "### END INIT INFO\n", "PORT=80\n", "RAILS_ROOT=\"/root/cloudpatrol\"\n", "COMMAND=\"rails server -p$PORT -d\"\n", "do_start()\n", "{\n", "  cd $RAILS_ROOT && $COMMAND\n", "}\n", "case \"$1\" in\n", "  start)\n", "    do_start\n", "  ;;\n", "esac\n"), :owner => 'root', :group => 'root' } } } } }, :Properties => {
      :KeyName => ref('KeyName'),
      :ImageId => find_in_map('RegionMap', aws_region, 'AMI'),
      :SecurityGroups => [ ref('FrontendGroup') ],
      :InstanceType => ref('InstanceType'),
      :Tags => [
          { :Key => 'Name', :Value => 'CloudPatrol' },
      ],
      :UserData => base64(
          join('',
               "#!/bin/bash -e\n",
               "yum update -y aws-cfn-bootstrap\n",
               "gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3\n",
               "yum -y groupinstall 'Development Tools'\n",
               "yum -y install git gcc ruby-devel zlib-devel libxml2 libxslt libxml2-devel libxslt-devel mlocate\n",
               "updatedb\n",
               "curl -L https://get.rvm.io | bash -s stable\n",
               "source /usr/local/rvm/scripts/rvm\n",
               "rvm requirements\n",
               "rvm install 1.9.3\n",
               "rvm use 1.9.3 --default\n",
               "rvm rubygems current\n",
               "gem install rails --no-ri --no-rdoc\n",
               "git clone https://github.com/stelligent/cloudpatrol.git\n",
               "cd ~/cloudpatrol\n",
               "bundle install --without development test doc\n",
               "bundle exec rake db:setup\n",
               "rails server -p80 -d\n",
               '/opt/aws/bin/cfn-signal',
               ' -e 0',
               ' \'',
               ref('WaitHandle'),
               "'\n",
          )
      ),
  }

  resource 'FrontendGroup', :Type => 'AWS::EC2::SecurityGroup', :Properties => {
      :GroupDescription => 'Enable SSH',
      :SecurityGroupIngress => [
          { :IpProtocol => 'tcp', :FromPort => '22', :ToPort => '22', :CidrIp => '0.0.0.0/0' },
          { :IpProtocol => 'tcp', :FromPort => '80', :ToPort => '80', :CidrIp => '0.0.0.0/0' },
      ],
  }

  resource 'IPAddress', :Type => 'AWS::EC2::EIP'

  resource 'IPAssociation', :Type => 'AWS::EC2::EIPAssociation', :Properties => {
      :InstanceId => ref('Ec2Instance'),
      :EIP => ref('IPAddress'),
  }

  resource 'WaitHandle', :Type => 'AWS::CloudFormation::WaitConditionHandle'

  resource 'WaitCondition', :Type => 'AWS::CloudFormation::WaitCondition', :DependsOn => 'Ec2Instance', :Properties => {
      :Handle => ref('WaitHandle'),
      :Timeout => '1500',
  }

  output 'URL',
         :Value => join('', 'http://', ref('IPAddress'), '/')

  output 'InstanceIPAddress',
         :Value => join('', ref('IPAddress'))

end.exec!
