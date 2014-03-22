module Emailer
  module RecipientsController
    def self.included(base)

      def recipient_email
        @recipient_email ||= current_user.emails.find(params[:email_id])
      end

      def add_recipient(contact)
        tracking = TrackingPixel.generate_token({email_id: recipient_email.id, contact_id: contact.id}) rescue nil
        if tracking
          status 201
          json contact
        else
          status 403
          json nil
        end
      end

      base.post '/emails/:email_id/recipients.?:format?' do
        contact = Contact.where(user_id: current_user.id, email_address: params[:email]).first
        contact ||= Contact.create!(user_id: current_user.id, email_address: params[:email])
        add_recipient(contact)
      end

      base.post '/emails/:email_id/recipients/:id' do
        contact = current_user.contacts.find(params[:id])
        add_recipient(contact)
      end

      base.post '/emails/:email_id/groups/:id' do
        status 201
        group = current_user.groups.find(params[:id])
        group.contacts.each do |contact|
          TrackingPixel.generate_token({email_id: recipient_email.id, contact_id: contact.id}) rescue nil
        end
        json nil
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
