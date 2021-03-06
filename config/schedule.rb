# set :output, "/path/to/my/cron_log.log"

# Redefining default runner job for Rails 4
job_type :runner, "cd :path && bin/rails runner ':task' :output"

# Parsing arguments
begin
  run_at = Time.parse(@rules_run_at)
rescue ArgumentError, TypeError
  raise ArgumentError, "rules_run_at is in the wrong format"
end

# Crontab contents
every :day, at: run_at do
  runner 'TaskRunner.new(class: "OpsWorks", method: "clean_stacks").run'
  runner 'TaskRunner.new(class: "CloudFormation", method: "clean_stacks").run'
  # EC2#clean_instances should run after CloudFormation
  runner 'TaskRunner.new(class: "EC2", method: "clean_instances").run'
  #runner 'TaskRunner.new(class: "EC2", method: "clean_security_groups").run'
  runner 'TaskRunner.new(class: "EC2", method: "clean_ports_in_default").run'
  runner 'TaskRunner.new(class: "EC2", method: "clean_elastic_ips").run'
  #runner 'TaskRunner.new(class: "IAM", method: "clean_users").run'
end
