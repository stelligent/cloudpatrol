Executing a new CloudPatrol rule/task from the CloudPatrol Rails app
==============

## Description

A new rule in CloudPatrol describes a set a tasks that will be performed on a scheduled basis as part of CloudPatrol. You must first create a Ruby [gem](https://github.com/stelligent/cloudpatrol_gem) that defines the new task and then call it from this Rails application.  

## Steps for Creating a New CloudPatrol Task in the Rails app

Yet another adapter to Cloudpatrol gem is used in Rails app (TaskRunner class in `app/classes/task_runner.rb`). It makes sure that the task is actually implemented in the gem, fetches needed arguments from DB (if necessary - be sure to add a setting to db/seeds.rb and catch it in the `TaskRunner.fetch_arg`) and finally calls `Cloudpatrol.perform`.
Example row to paste into `app/views/commands/index.html.haml` view:

`%tr`
  `%td`
    `Do something but with`
    `= aws_setting :ec2_limit_of_something`
    `in mind`
  `%td= perform_link class: :EC2, method: :do_something`
 

Practically nothing else needs to be done inside Rails. This will add a row to Commands page and “perform” link will not be displayed unless every required setting (`ec2_limit_of_something` in this case) is present.