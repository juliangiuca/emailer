module Emailer
  module RecipientsController
    def self.included(base)

      def email
        email = current_user.emails.find(params[:email_id])
      end

      base.post '/emails/:email_id/recipients.?:format?' do
        contact = Contact.where(user_id: current_user.id, id: params[:contactId]).first
        json TrackingPixel.generate_token({email_id: email.id, contact_id: contact.id})
      end

      base.get '/emails/:email_id/recipients/:id' do
        json email.recipients.to_a
      end

      base.get '/emails/:email_id/recipients' do
        json email.recipients.to_a
      end
    end
  end
end
