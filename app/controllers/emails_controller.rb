module Emailer
  module EmailsController
    def self.included(base)

      def email_from_id
        @email_from_id ||= current_user.emails.find(params[:id])
      end

      base.patch '/emails/:id' do
        attr = params[:changed]
        raise unless ["subject", "body"].include?(attr)

        email_from_id.update_attribute(attr, @request_payload[attr])
        json email_from_id
      end

      base.post '/emails.?:format?' do
        status 201
        email_from_id = current_user.emails.create!()
        json zemail
      end

      base.get '/emails/:id.?:format?' do
        json email_from_id
      end

      base.get '/emails.?:format?' do
        json current_user.emails.to_a
      end

      base.post '/emails/:id/send' do
        status 201
        email_from_id.send!
        json nil
      end

    end
  end
end
