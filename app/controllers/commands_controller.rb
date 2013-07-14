class CommandsController < ApplicationController
  def index
    @settings = Setting.all.to_hash
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end

  def perform
    if TaskRunner.new(class: params[:class], method: params[:method]).run
      flash[:notice] = "Command was executed, check the logs."
    else
      flash[:alert] = "Wrong, wrong."
    end
    redirect_to commands_path
  end
end
