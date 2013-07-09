class CommandsController < ApplicationController
  def index
    @settings_arr = Setting.all.map { |s| [s.key.to_sym, s.value] }
    @settings = {}
    @settings_arr.each do |s|
      @settings[s[0]] = s[1]
    end
  end
end
