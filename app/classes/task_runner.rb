class TaskRunner
  def initialize command = {}
    @command = {
      class: command[:class].to_sym,
      method: command[:method].to_sym
    }
    @creds = creds
  end

  def run
    if @creds and task_class_has_public_method(@command[:class],@command[:method])
      request_args = prepare_cloudpatrol_arguments(@creds, log_table_name, @command[:class], @command[:method])
      request = Cloudpatrol.perform(*request_args)
    else
      raise
    end
  rescue
    false
  end

private

  def prepare_cloudpatrol_arguments(creds, log_table_name, task_class_name, method_name)
    request_args = [ creds, log_table_name, task_class_name, method_name ]
    task_arg = fetch_arg
    unless task_arg.nil?
      request_args << task_arg
    end
    request_args
  end

  def task_class_has_public_method(task_class_name, method_name)
    Cloudpatrol::Task.const_get(task_class_name).public_instance_methods(false).include?(method_name)
  end

  def fetch_arg
    arg = case @command[:class]
          when :EC2
            'ec2_instance_age' if @command[:method] == :clean_instances
          when :OpsWorks
            case @command[:method]
            when :clean_stacks
              'opsworks_stack_age'
            when :clean_layers
              'opsworks_layer_age'
            when :clean_instances
              'opsworks_instance_age'
            when :clean_apps
              'opsworks_app_age'
            end
          when :CloudFormation
            'cloudformation_stack_age' if @command[:method] == :clean_stacks
          end

    if arg
      if (s = Setting.find_by_key(arg).try(:value)).present?
        s.to_i
      else
        raise "#{arg} must exist"
      end
    else
      nil
    end
  end

  def log_table_name
    Setting.find_by_key('dynamodb_log_table').try(:value) || 'cloudpatrol-log'
  end

  def creds
    if access_key_id = Setting.find_by_key('aws_access_key_id').try(:value) and secret_access_key = Setting.find_by_key('aws_secret_access_key').try(:value)
      {
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
      }
    else
      nil
    end
  end
end
