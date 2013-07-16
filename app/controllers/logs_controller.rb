class LogsController < ApplicationController
  def index
    @settings = Setting.all.to_hash
    @log = []
    if @settings[:aws_access_key_id] and @settings[:aws_secret_access_key] and @settings[:dynamodb_log_table]
      AWS.config(access_key_id: @settings[:aws_access_key_id], secret_access_key: @settings[:aws_secret_access_key])
      db = AWS::DynamoDB.new
      t = db.tables[@settings[:dynamodb_log_table]]
      if t.exists? and t.status == :active
        t.load_schema
        t.items.each do |item|
          @log << item.attributes.to_hash
        end
        @log.map! do |item|
          {
            time: Time.parse(item["time"]),
            action: item["action"],
            response: item["response"]
          }
        end
        @log.sort!{|x,y| y[:time] <=> x[:time] }
      else
        flash.now[:alert] = "DynamoDB table \"#{t.name}\" doesn't exist or is not active"
      end
    else
      flash.now[:alert] = "Change your settings"
    end
  end
end
