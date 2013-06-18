class StaticPagesController < ApplicationController
  def root
    if current_user
      render "settings/index"
    end
  end

  def favicon
    render nothing: true
  end
end
