class LogsController < ApplicationController
  def index
    @settings = Setting.all.to_hash
    @log = Cloudpatrol.get_log({ access_key_id: @settings[:aws_access_key_id], secret_access_key: @settings[:aws_secret_access_key] }, @settings[:dynamodb_log_table])
    flash.now[:alert] = @log[:error] unless @log[:success]
  end
end
