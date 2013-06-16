class SessionsController < ApplicationController
  before_filter :authorize, only: [ :destroy ]

  def new
  end

  def create
    if user = User.find_by_name(params[:name]) and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = "Invalid credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

private

  def app_params
    params.require :email, :password, :password_confirmation
  end
end
