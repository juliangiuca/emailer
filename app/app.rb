
module Emailer
  class App < Sinatra::Base
    helpers Sinatra::JSON
    set :public_folder, File.join(File.dirname(__FILE__), "..", '/public')

    get '/' do
      haml :index
    end

    get '/campaigns' do
      json Campaign.all
    end

    post '/campaigns' do
      Campaign.create!
    end

    get '/campaigns/:campaign_id' do
      haml "views/campaigns/show"
    end

    get '/users/' do
      haml "views/users/index"
    end

    get '/users/:user_id' do
      haml "views/users/show"
    end
  end
end
