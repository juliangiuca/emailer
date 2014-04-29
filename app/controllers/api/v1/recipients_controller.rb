class Api::V1::RecipientsController < Api::ApiController

  def index
    render json: email.recipients.to_a
  end

  def create
    add_recipient_by_email || add_recipient_by_id || add_recipient_by_group
  end

  def destroy
    TrackingPixel.where(email_id: email.id, contact_id: params[:id]).destroy_all
    render json nil, status: :deleted
  end

  private
  def email
    current_user.emails.find(params[:email_id])
  end

  def add_recipient_by_email
    return nil unless params[:emailAddress]

    contact = Contact.where(user_id: current_user.id, email_address: params[:emailAddress]).first
    contact ||= Contact.create!(user_id: current_user.id, email_address: params[:emailAddress])
    add_recipient(contact)
  end

  def add_recipient_by_id
    return nil unless params[:contactId]

    contact = current_user.contacts.find(params[:contactId])
    add_recipient(contact)
  end

  def add_recipient_by_group
    return nil unless params[:groupId]

    group = current_user.groups.find(params[:groupId])

    group.contacts.each do |contact|
      TrackingPixel.generate_token({email_id: email.id, contact_id: contact.id}) rescue nil
    end
    render json: nil, status: :created
  end


  def add_recipient(contact)
    tracking = TrackingPixel.generate_token({email_id: email.id, contact_id: contact.id})
    render json: contact, status: :created

  rescue StandardError => e
    render json: {error: e.message}, status: :forbidden
  end

end
