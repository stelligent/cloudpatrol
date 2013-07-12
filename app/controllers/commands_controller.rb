class CommandsController < ApplicationController
  before_action :discover_command, only: [ :perform ]

  def index
    @settings = Setting.to_hash
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end

  # TODO: Extract to TaskRunner class
  def perform
    if @command and creds
      request_args = [ creds, log_table_name, @command[:class], @command[:method] ]
      task_args = retrieve_args_for(@command)
      request_args << task_args if task_args.present?

      request = Cloudpatrol.perform(*request_args)

      flash[:notice] = "#{@command} was executed"
    else
      flash[:alert] = "Wrong, wrong."
    end
    redirect_to commands_path
  end

private

  def discover_command
    @command = begin
      if params[:class] and params[:method] and Cloudpatrol::Task.const_get(params[:class].to_sym).public_instance_methods(false).include?(params[:method].to_sym)
        {
          class: params[:class].to_sym,
          method: params[:method].to_sym
        }
      else
        raise
      end
    rescue
      nil
    end
  end

  def retrieve_args_for command
    when :EC2
      "ec2_instance_age" if command[:method] == :clean_instances
    when :OpsWorks
      case command[:method]
      when :clean_stacks
        "opsworks_stack_age"
      when :clean_layers
        "opsworks_layer_age"
      when :clean_instances
        "opsworks_instance_age"
      when :clean_apps
        "opsworks_app_age"
      end
    when :CloudFormation
      "cloudformation_stack_age" if command[:method] == :clean_stacks
    end
    return Setting.find_by_key(arg).try(:value) if arg
    nil
  end

  def log_table_name
    Setting.find_by_key("dynamodb_log_table").try(:value)
  end

  def creds
    if access_key_id = Setting.find_by_key("aws_access_key_id").value and secret_access_key = Setting.find_by_key("aws_secret_access_key").value
      {
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
      }
    else
      nil
    end
  end
end
