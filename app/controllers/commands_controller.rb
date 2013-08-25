class CommandsController < ApplicationController
  before_filter :get_settings, only: [ :index, :schedule ]

  def index
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end

  def perform
    if TaskRunner.new(class: params[:class], method: params[:method]).run
      flash[:notice] = "Command was executed, check the logs"
    else
      flash[:alert] = "Failure"
    end
    redirect_to commands_path
  end

  def schedule
    args = @settings.select{ |k,v| [ :rules_run_at ].include?(k) }.to_a.map{ |s| "#{s[0]}=#{s[1]}" }.join("&")
    response = system("cd #{Rails.root}; bundle exec whenever --update-crontab --set '#{args}'")
    if response
      flash[:notice] = "Schedule updated"
    else
      flash[:alert] = "Failure"
    end
    redirect_to commands_path
  end

  def unschedule
    response = system("cd #{Rails.root}; bundle exec whenever -c")
    if response
      flash[:notice] = "Schedule removed"
    else
      flash[:alert] = "Failure"
    end
    redirect_to commands_path
  end

  private

  def get_settings
    @settings = Setting.all.to_hash
  end
end
