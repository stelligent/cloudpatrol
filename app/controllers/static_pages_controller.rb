class StaticPagesController < ApplicationController
  def root
    # Render settings to logged user
    if current_user
      redirect_to settings_path
    end
  end

  def favicon
    render nothing: true
  end
end
