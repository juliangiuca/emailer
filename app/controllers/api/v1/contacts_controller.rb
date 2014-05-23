class Api::V1::ContactsController < Api::ApiController

  def index
    render json: current_user.contacts.to_a
  end

  def update
    contact.update!(contact_params)
    render json: contact
  end

  def create
    contact = Contact.create!(user_id: current_user.id, email_address: params[:email_address])

    render json: contact, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: {error: e.message}, status: :conflict
  end

  def destroy
    contact.destroy
    render nothing: true, status: :ok
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: :not_found
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email_address)
  end

  def contact
    @contact ||= current_user.contacts.find_by!(id: params[:id])
  end
end
