class Api::SettingsController < ApiController
  before_filter :get_setting, only: [ :show, :update, :destroy ]

  def index
    render json: Setting.all
  end

  def create
    @setting = Setting.new(params[:setting])
    @setting.save
    render json: @setting
  end

  def show
    render json: @setting
  end

  def update
    @setting.update_attributes(params[:setting])
    render json: @setting
  end

  def destroy
    @setting.destroy
    render json: @setting
  end

private

  def get_setting
    @setting ||= (Setting.find_by_key(params[:id]) or Setting.find_by_id(params[:id]))
  end
end
