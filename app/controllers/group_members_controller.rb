module Emailer
  module GroupMembersController
    def self.included(base)

      def group_member_group
        @group ||= current_user.groups.find(params[:group_id])
      end

      base.get '/groups/:group_id/members' do
        json group_member_group.contacts
      end

      base.post '/groups/:group_id/members' do
        status 201

        contact = Contact.where(user_id: current_user.id, email_address: params[:contactEmail]).first
        contact ||= Contact.create!(user_id: current_user.id, email_address: params[:contactEmail])

        group_member_group.contacts << contact

        json contact
      end

      base.delete '/groups/:group_id/members/:id' do
        status 204

        group_member_group.contacts.find(params[:id]).destroy
        json nil
      end

    end
  end
end
