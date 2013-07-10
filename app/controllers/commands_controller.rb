class CommandsController < ApplicationController
  def index
    @settings_arr = Setting.all.map { |s| [s.key.to_sym, s.value] }
    @settings = {}
    @settings_arr.each do |s|
      @settings[s[0]] = s[1] if s[1].present?
    end
    unless @settings[:aws_access_key_id] and @settings[:aws_secret_access_key]
      flash.now[:alert] = "AWS credentials are missing!"
      @disable_commands = true
    end
  end
end
