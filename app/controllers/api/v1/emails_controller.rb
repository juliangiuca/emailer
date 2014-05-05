class Api::V1::EmailsController < Api::ApiController

  def index
    render json: current_user.emails.order("id desc").to_a
  end

  def create
    email = current_user.emails.create!
    render json: email, status: :created
  end

  def show

    render json: email

  rescue NoMethodError, ActiveRecord::RecordNotFound => e
    render nothing: true, status: :not_found
  end

  def update
    email.update!(email_params)
    render json: email
  end

  def deliver
    email.deliver!
    render nothing: true, status: :created
  end

  private
  def email
    @email ||= current_user.emails.find(params[:id])
  end

  def email_params
    params.require(:email).permit(:subject, :body)
  end
end
