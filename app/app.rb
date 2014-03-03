require 'sinatra'
require 'sinatra/base'
require 'sinatra/advanced_routes'
require "sinatra/json"
require 'haml'
require_relative "boot/controllers"

module Emailer
  class App < Sinatra::Base
    helpers Sinatra::JSON

    register Sinatra::AdvancedRoutes

    set :public_folder, File.join(File.dirname(__FILE__), "..", '/public')
    set(:accepted_verbs) { |*verbs| condition { verbs.any?{|v| v == request.request_method }  } }
    Haml::Options.defaults[:format] = :html5

    use Sass::Plugin::Rack

    #use ActiveRecord::ConnectionAdapters::ConnectionManagement

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == Settings.basic_auth.username && password == Settings.basic_auth.password
    end

    Emailer::Boot::Controller.include_controllers!(self)

    before "*", accepted_verbs: ["POST", "PATCH", "PUT"] do
      request.body.rewind
      @request_payload = JSON.parse request.body.read
    end

    get '/' do
      haml :index
    end

    get '/ngView/:ngController/:ngAction' do
      haml :"ng_view/#{params[:captures].join("/")}"
    end

  end
end

