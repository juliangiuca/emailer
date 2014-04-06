class WelcomeController < ApplicationController

  layout "welcome"

  def index
    if !user_signed_in?
      redirect_to user_omniauth_authorize_path(:google_oauth2) and return
    end
  end
end
