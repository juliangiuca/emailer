module Emailer
  module RecipientsController
    def self.included(base)

      def recipient_email
        @recipient_email ||= current_user.emails.find(params[:email_id])
      end

      base.post '/emails/:email_id/recipients.?:format?' do
        contact = Contact.where(user_id: current_user.id, email_address: params[:contactEmail]).first
        contact ||= Contact.create!(user_id: current_user.id, email_address: params[:contactEmail])
        TrackingPixel.generate_token({email_id: recipient_email.id, contact_id: contact.id})
        json contact
      end

      base.get '/emails/:email_id/recipients/:id' do
        json recipient_email.recipients.to_a
      end

      base.get '/emails/:email_id/recipients' do
        json recipient_email.recipients.to_a
      end

      base.delete '/emails/:email_id/recipients/:id' do
        status 204
        TrackingPixel.where(email_id: recipient_email.id, contact_id: params[:id]).destroy_all
        json nil
      end
    end
  end
end
