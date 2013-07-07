class SettingsController < ApplicationController
  before_filter :authorize
  before_action :set_setting, only: [ :show, :edit, :update, :destroy ]

  def index
    @settings = Setting.all
  end

  def new
    @setting = Setting.new
  end

  def show
    if @setting
      render json: @setting
    else
      render nothing: true
    end
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to @setting, notice: 'Setting was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @setting.update(setting_params)
      # redirect_to @setting, notice: 'Setting was successfully updated.'
    else
      # render action: 'edit'
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @setting.destroy
    redirect_to settings_url, notice: 'Setting was successfully destroyed.'
  end

private

  def set_setting
    @setting =
    begin
      Setting.find(params[:id])
    rescue
      Setting.find_by_key(params[:id])
    end
  end

  def setting_params
    params.require(:setting).permit(:key, :value, :protected)
  end
end
