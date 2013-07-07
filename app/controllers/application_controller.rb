class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

private

  def authorize
    if current_user or grant_api_access
      true
    else
      redirect_to root_path, alert: "Unauthorized"
      false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def grant_api_access
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(api_key: token)
    end
  end
end
