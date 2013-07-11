class CommandsController < ApplicationController
  before_action :discover_command, only: [ :perform ]

  def index
    @settings = Setting.to_hash
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end

  def perform
    if @command
      # command runs
      klass = Cloudpatrol::Task.const_get(@command[:class])
      if klass.new(creds).try(@command[:method])
        flash.now[:notice] = "#{@command} was executed"
      end
    else
      flash.now[:alert] = "Wrong, wrong."
    end
    redirect_to commands_path
  end

private

  def discover_command
    @command =
      if params[:class] and params[:method] and Cloudpatrol::Task.const_get(params[:class].to_sym).public_instance_methods(false).include?(params[:method].to_sym)
        {
          class: params[:class].to_sym,
          method: params[:method].to_sym
        }
      else
        nil
      end
  end

  def creds
    {
      access_key_id: Setting.find_by_name("aws_access_key_id"),
      secret_access_key: Setting.find_by_name("aws_secret_access_key")
    }
  end
end
