class NgViewsController < ApplicationController

  def get
    render "ng_views/#{params[:url]}", layout: false
  end
end
