class Api::V1::MembersController < Api::ApiController

  def index
    render json: group.contacts.to_a
  end

  def create
    contact = Contact.where(user_id: current_user.id, email_address: params[:contactEmail]).first
    contact ||= Contact.create!(user_id: current_user.id, email_address: params[:contactEmail])

    group.contacts << contact

    render json: contact, status: :created
  end

  def bulk
    emails = params[:emails]
    emails = emails.split(",")
    emails.each do |email|
      contact = current_user.contacts.find_by(email_address: email.strip)
      contact ||= current_user.contacts.create!(email_address: email.strip)

      group.contacts << contact
    end

    render json: nil, status: :created
  end

  private
  def group
    @group ||= current_user.groups.find(params[:group_id])
  end
end
