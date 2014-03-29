class EmailsController < ApiController

  def index
    render json: current_user.emails.to_a
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
    attr = params[:changed]
    raise unless ["subject", "body"].include?(attr)

    email.update_attribute(attr, request_body[attr])
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
end
