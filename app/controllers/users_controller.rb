module Emailer
  module UsersController
    def self.included(base)
      base.get '/users.?:format?' do
        json User.all
      end

      base.post '/users' do
        json User.create!(@request_payload)
      end

      base.get '/users/:user_id' do
        haml "views/users/show"
      end
    end
  end
end
