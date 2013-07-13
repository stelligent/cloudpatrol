class SettingsController < ApplicationController
  before_filter :authorize
  before_action :set_setting, only: [ :update, :destroy ]

  def index
    @settings = Setting.all
  end

  # def create
  #   @setting = Setting.new(setting_params)

  #   if @setting.save
  #     redirect_to @setting, notice: 'Setting was successfully created.'
  #   else
  #     render nothing: true
  #   end
  # end

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
