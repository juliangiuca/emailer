require_relative '../../lib/email_delegate'

class EmailJob
  @queue = :default

  def self.perform(email_id)
    email = Email.where(id: email_id).includes(:tracking_pixels).references(:tracking_pixels).first
    user = email.user
    user.refresh_access_token!

    email.tracking_pixels.each do |tracking_pixel|
      Resque.enqueue(EmailJob::ToRecipient, email.id, tracking_pixel.id)
    end
  end

  class ToRecipient
    @queue = :default

    def self.perform(email_id, tracking_pixel_id)
      email          = Email.find(email_id)
      user           = email.user
      tracking_pixel = TrackingPixel.includes(:contact).find(tracking_pixel_id)

      return if tracking_pixel.sent?

      tracked_email = EmailDelegate.new(email)
      tracked_email.tracking_pixel = tracking_pixel

      mail = Mail.new do
        content_type  'text/html; charset=UTF-8'
        from          user.email_address
        to            tracking_pixel.contact.email_address
        subject       email.subject
        body          tracked_email.html
      end

      mail.delivery_method.settings.merge!({
        user_name: user.email_address,
        password:  user.access_token
      })

      mail.deliver!
      tracking_pixel.update_attribute(sent, true)
    end
  end
end
