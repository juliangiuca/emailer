require_relative '../../config/boot'

class EmailCampaignJob
  @queue = :default

  def self.perform(campaign_id)
    campaign = Campaign.where(id: campaign_id).includes(:users).references(:users).first

    campaign.users.each do |user|
      Resque.enqueue(EmailCampaignJob::ToUser, campaign.id, user.id)
    end
  end

  class ToUser
    @queue = :default

    def self.perform(campaign_id, user_id)
      campaign = Campaign.includes(:tracked_users).find(campaign_id)
      user = User.find(user_id)

      return if campaign.tracked_users.to_a.include?(user)

      tracked_email = CampaignDelegate.new(campaign)
      tracked_email.for_user = user

      mail = Mail.new do
        content_type 'text/html; charset=UTF-8'
        from    'me@eggandjam.com'
        to      'me@eggandjam.com'
        subject "#{campaign.name}"
        body    tracked_email.parsed_body
      end
      mail.deliver!
    end
  end
end
