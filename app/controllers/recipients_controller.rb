class RecipientsController < ApiController
  def index
    render json: email.recipients.to_a
  end

private
    def email
      current_user.emails.find(params[:email_id])
    end
end
