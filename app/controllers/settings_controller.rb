class SettingsController < ApplicationController
  before_filter :authorize
  before_action :set_setting, only: [ :update, :destroy ]

  def index
    @settings = Setting.all
  end

  def create
    @setting = Setting.new(setting_params)
    @success = !!@setting.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @success = !!@setting.update(setting_params)

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
    @setting = Setting.find_by_id(params[:id]) or Setting.find_by_key(params[:id]) or raise ActiveRecord::RecordNotFound
  end

  def setting_params
    permitted_fields = [ :key, :value, :protected ]
    if @setting
      permitted_fields.delete(:key) if @setting.key_protected?
      permitted_fields.delete(:value) if @setting.value_protected?
    end
    params.require(:setting).permit(permitted_fields)
  end
end
