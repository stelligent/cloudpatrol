# set :output, "/path/to/my/cron_log.log"

# Redefining default runner job for Rails 4
job_type :runner, "cd :path && bin/rails runner ':task' :output"

if start_time = Time.parse(@ec2_instances_start_time) and stop_time = Time.parse(@ec2_instances_stop_time)
  every :day, at: start_time do
    runner 'TaskRunner.new(class: "EC2", method: "start_instances").run'
  end

  every :day, at: stop_time do
    runner 'TaskRunner.new(class: "EC2", method: "stop_instances").run'
  end
end
