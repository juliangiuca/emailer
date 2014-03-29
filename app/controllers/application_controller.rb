class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user = User.where(id: session[:current_user]).first
  end

  def current_user=(user)
    byebug
    session[:current_user] = user.id
  end

  def request_body
    @request_body ||= JSON.load(request.body)
  end
end
