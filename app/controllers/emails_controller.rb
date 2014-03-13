module Emailer
  module EmailsController
    def self.included(base)

      base.patch '/emails/:id' do
        email = current_user.emails.find(params[:id])
        attr = params[:changed]
        raise unless ["subject", "body"].include?(attr)

        email.update_attribute(attr, @request_payload[attr])
        json email
      end

      base.post '/emails.?:format?' do
        email = current_user.emails.create!()
        json email
      end

      base.get '/emails/:id.?:format?' do
        email = Email.where(user_id: current_user.id, id: params[:id]).first
        json email
      end

      base.get '/emails.?:format?' do
        json current_user.emails.to_a
      end

    end
  end
end
