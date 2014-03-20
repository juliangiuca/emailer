module Emailer
  module GroupsController
    def self.included(base)

      def group
        @group ||= current_user.groups.find(params[:id])
      end

      base.get '/groups.?:format?' do
        json current_user.groups.to_a
      end

      base.post '/groups' do
        status 201
        json current_user.groups.create!(@request_payload)
      end

      base.get '/groups/:id' do
        group = current_user.groups.find(params[:id])
        json group
      end

      base.get '/groups/:id/members' do
        group = current_user.groups.includes(:contacts).find(params[:id])
        json group.contacts
      end

      base.post '/groups/:id/members' do
        status 201

        contact = Contact.where(user_id: current_user.id, email_address: params[:contactEmail]).first
        contact ||= Contact.create!(user_id: current_user.id, email_address: params[:contactEmail])

        group.contacts << contact

        json contact

      end

    end
  end
end
