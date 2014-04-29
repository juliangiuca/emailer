class UIController < ApplicationController
  before_filter :ensure_logged_in

  private
  def ensure_logged_in
    redirect_to welcome_path if !user_signed_in?
  end
end
