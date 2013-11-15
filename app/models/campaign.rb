# == Schema Information
#
# Table name: campaigns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  body       :text
#  sent       :boolean
#

class Campaign < ActiveRecord::Base
  has_many :tracking_pixels
  has_many :tracked_users, through: :tracking_pixels, source: :user

  has_many :campaign_users, dependent: :destroy
  has_many :users, through: :campaign_users

  def deliver
    Resque.enqueue(EmailCampaignJob, self.id)
  end
end
