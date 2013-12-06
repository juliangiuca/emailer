

module Emailer
  class App < Sinatra::Base
    helpers Sinatra::JSON
    set :public_folder, File.join(File.dirname(__FILE__), "..", '/public')
    set(:accepted_verbs) { |*verbs| condition { verbs.any?{|v| v == request.request_method }  } }
    Haml::Options.defaults[:format] = :html5

    use Sass::Plugin::Rack

    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == Settings.basic_auth.username && password == Settings.basic_auth.password
    end

    before "*", accepted_verbs: ["POST", "PATCH", "PUT"] do
      request.body.rewind
      @request_payload = JSON.parse request.body.read
    end

    get '/' do
      haml :index
    end

    get '/campaigns/:campaign_id' do
      json Campaign.find(params[:campaign_id])
    end

    patch '/campaigns/:campaign_id' do
      campaign = Campaign.find(params[:campaign_id])
      attr = params[:changed]
      raise unless ["name", "body"].include?(attr)

      campaign.update_attribute(attr, @request_payload[attr])
      json campaign
    end

    post '/campaigns/:campaign_id/deliver' do
      campaign = Campaign.find(params[:campaign_id])
      campaign.deliver
      json campaign
    end

    get '/campaigns/:campaign_id/users' do
      campaign = Campaign.find(params[:campaign_id])
      json campaign.users
    end

    post '/campaigns/:campaign_id/users' do
      campaign = Campaign.find(params[:campaign_id])
      user = User.where(email: @request_payload["email"]).includes(:campaigns).references(:campaigns).first
      if !user.campaigns.include?(campaign)
        campaign.users << user
      end

      json user
    end

    delete '/campaigns/:campaign_id/users/:user_id' do
      campaign_user = CampaignUser.where(user_id: params[:user_id], campaign_id: params[:campaign_id]).first
      campaign_user.try(:delete)
    end

    get '/campaigns.?:format?' do
      json Campaign.all
    end

    post '/campaigns' do
      json Campaign.create!(@request_payload)
    end


    get '/users.?:format?' do
      json User.all
    end

    post '/users' do
      json User.create!(@request_payload)
    end

    get '/users/:user_id' do
      haml "views/users/show"
    end

    get '/ngView/:ngController/:ngAction' do
      haml :"ng_view/#{params[:captures].join("/")}"
    end

    get '/tp/:token' do
      tp = TrackingPixel.where(tracking: params[:token]).includes(:user).first
      logger.info "tracking #{tp.user.name} for campaign #{tp.campaign_id}"
      tp.views += 1
      tp.date_first_viewed ||= Date.today
      tp.save!
      sleep 5
      redirect request.url
      #send_file "public/tracking_pixel.gif"
    end

    get "/status/info" do
      revision = `git rev-parse --short --verify HEAD`.chomp
      {
        :git_revision => revision,
        :git_local_branch => `git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/'`.chomp,
        :git_committed_at => `git show -s --format="%ci" #{revision}`.chomp,
        :git_commit_message => `git log -1 --pretty=format:"%s"`.chomp,
        :git_remote_branches => `git branch --no-color -r --contains #{revision} | grep -v 'HEAD' | tr -cs "[:print:]" " "`.chomp
      }.to_s
    end

    #get '/stylesheets/*' do
      #sass :"sass/#{params[:splat].first.to_sym}", style: :expanded
    #end
  end
end
