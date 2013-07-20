class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :restrict_api_access, except: [ :index, :show ]

private

  def restrict_api_access
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(api_key: token)
    end
  end
end
