module Emailer
  module CampaignsController
    def self.included(base)
      base.get '/campaigns/:campaign_id' do
        json Campaign.find(params[:campaign_id])
      end

      base.patch '/campaigns/:campaign_id' do
        campaign = Campaign.find(params[:campaign_id])
        attr = params[:changed]
        raise unless ["name", "body"].include?(attr)

        campaign.update_attribute(attr, @request_payload[attr])
        json campaign
      end

      base.post '/campaigns/:campaign_id/deliver' do
        campaign = Campaign.find(params[:campaign_id])
        campaign.deliver
        json campaign
      end

      base.get '/campaigns/:campaign_id/users' do
        campaign = Campaign.find(params[:campaign_id])
        json campaign.users
      end

      base.post '/campaigns/:campaign_id/users' do
        campaign = Campaign.find(params[:campaign_id])
        user = User.where(email: @request_payload["email"]).includes(:campaigns).references(:campaigns).first
        if !user.campaigns.include?(campaign)
          campaign.users << user
        end

        json user
      end

      base.delete '/campaigns/:campaign_id/users/:user_id' do
        campaign_user = CampaignUser.where(user_id: params[:user_id], campaign_id: params[:campaign_id]).first
        campaign_user.try(:delete)
      end

      base.get '/campaigns.?:format?' do
        json Campaign.all
      end

      base.post '/campaigns' do
        json Campaign.create!(@request_payload)
      end
    end
  end
end
