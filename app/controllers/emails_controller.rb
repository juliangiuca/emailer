module Emailer
  module EmailsController
    def self.included(base)

      base.patch '/emails/:id' do
        email = current_user.emails.find(params[:campaign_id])
        attr = params[:changed]
        raise unless ["name", "body"].include?(attr)

        email.update_attribute(attr, @request_payload[attr])
        json email
      end

      base.post '/emails.?:format?' do
        email = current_user.emails.create!()
        json email
      end

      base.get '/emails/:id' do
        email = current_user.emails.find(params[:id])
        json campaign.users
      end

      base.get '/emails.?:format?' do
        json current_user.emails.all
      end
    end
  end
end
