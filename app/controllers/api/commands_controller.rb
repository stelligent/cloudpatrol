class Api::CommandsController < ApiController
  before_filter :get_commands, except: [ :schedule, :unschedule ]

  def index
    formatted_commands = []
    @commands.each do |c|
      c[1].each do |m|
        formatted_commands << command_format(class: c[0], method: m)
      end
    end
    render json: formatted_commands
  end

  def perform
    render json: {
      response: if TaskRunner.new(class: params[:class], method: params[:method]).run
        "Command was executed, check the logs"
      else
        "Failure"
      end
    }
  end

  def schedule
    render json: {
      response: if system("cd #{Rails.root}; bundle exec whenever -c")
        "Schedule removed"
      else
        "Failure"
      end
    }
  end

private

  def get_commands
    @commands ||= Cloudpatrol::Task.constants.map{ |c| [c, Cloudpatrol::Task.const_get(c).instance_methods(false)] }
  end

  def command_format command
    {
      class: command[:class],
      method: command[:method],
      url: "#{request.protocol}#{request.host_with_port}/api/commands/#{command[:class]}/#{command[:method]}"
    }
  end
end
