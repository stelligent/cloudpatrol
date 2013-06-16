class StaticPagesController < ApplicationController
  def root
    if current_user
      render "settings/index"
    end
  end
end
