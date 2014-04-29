class Api::ApiController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  before_filter :logged_in_only

  def logged_in_only
    user_signed_in? || (render(nothing: true, status: 401) && return)
  end

end
