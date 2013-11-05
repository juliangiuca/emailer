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
      campaign = Campaign.find(campaign_id)

      mail = Mail.new do
        from    'me@eggandjam.com'
        to      'me@eggandjam.com'
        subject "#{campaign.name}"
        body    campaign.body
      end
      mail.deliver!
    end
  end
end
