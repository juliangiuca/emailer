module Emailer
  module ContactsController
    def self.included(base)
      base.get '/contacts.?:format?' do
        json current_user.contacts.to_a
      end

      base.post '/contacts' do
        json current_user.contacts.create!(@request_payload)
      end

      base.get '/contacts/:contact_id' do
        haml "views/users/show"
      end

    end
  end
end
