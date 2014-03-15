require_relative '../../config/boot'

class EmailJob
  @queue = :default

  def self.perform(email_id)
    email = Email.where(id: email_id).includes(:tracking_pixels).references(:tracking_pixels).first

    email.tracking_pixels.each do |tracking_pixel|
      Resque.enqueue(EmailJob::ToRecipient, email.id, tracking_pixel.id)
    end
  end

  class ToRecipient
    @queue = :default

    def self.perform(email_id, tracking_pixel_id)
      email          = Email.find(email_id)
      tracking_pixel = TrackingPixel.find(tracking_pixel_id)

      return if tracking_pixel.sent?

      tracked_email = EmailDelegate.new(email)
      tracked_email.for_recipient = recipient

      mail = Mail.new do
        content_type 'text/html; charset=UTF-8'
        from    'me@eggandjam.com'
        to      'me@eggandjam.com'
        subject "#{email.subject}"
        body    tracked_email.parsed_body
      end
      mail.deliver!
    end
  end
end
