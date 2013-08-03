class UsersController < ApplicationController
  before_filter :authorize

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
      redirect_to profile_path
    else
      redirect_to edit_profile_path
    end
  end
end
