# set :output, "/path/to/my/cron_log.log"

# Redefining default runner job for Rails 4
job_type :runner, "cd :path && bin/rails runner ':task' :output"

# Parsing arguments
begin
  run_at = Time.parse(@rules_run_at)
rescue ArgumentError, TypeError
  raise ArgumentError, "rules_run_at is in the wrong format"
end
# begin
#   start_time = Time.parse(@ec2_instances_start_time)
# rescue ArgumentError, TypeError
#   raise ArgumentError, "ec2_instances_start_time is in the wrong format"
# end
# begin
#   stop_time = Time.parse(@ec2_instances_stop_time)
# rescue ArgumentError, TypeError
#   raise ArgumentError, "ec2_instances_stop_time is in the wrong format"
# end

# Crontab contents
every :day, at: run_at do
  runner 'TaskRunner.new(class: "EC2", method: "clean_instances").run'
  runner 'TaskRunner.new(class: "EC2", method: "clean_security_groups").run'
  runner 'TaskRunner.new(class: "EC2", method: "clean_ports_in_default").run'
  runner 'TaskRunner.new(class: "EC2", method: "clean_elastic_ips").run'
  runner 'TaskRunner.new(class: "IAM", method: "clean_users").run'
  runner 'TaskRunner.new(class: "OpsWorks", method: "clean_apps").run'
  runner 'TaskRunner.new(class: "OpsWorks", method: "clean_instances").run'
  runner 'TaskRunner.new(class: "OpsWorks", method: "clean_layers").run'
  runner 'TaskRunner.new(class: "OpsWorks", method: "clean_stacks").run'
  runner 'TaskRunner.new(class: "CloudFormation", method: "clean_stacks").run'
end
