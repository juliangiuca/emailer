class Api::V1::ContactsController < Api::ApiController
  def index
    render json: current_user.contacts.to_a
  end
end
