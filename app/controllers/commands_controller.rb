class CommandsController < ApplicationController
  def index
    @settings = Setting.to_hash
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end

  def perform
  end
end
