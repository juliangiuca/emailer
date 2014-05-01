class Api::V1::ContactsController < Api::ApiController
  def index
    render json: current_user.contacts.to_a
  end

  def update
    contact.update!(contact_params)
    render json: contact
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email_address)
  end

  def contact
    @contact ||= current_user.contacts.find(params[:id])
  end
end
