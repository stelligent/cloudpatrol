class StaticPagesController < ApplicationController
  def root
    # Render settings to logged user
    if current_user
      render "settings/index"
    end
  end

  def favicon
    render nothing: true
  end
end
