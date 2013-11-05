# == Schema Information
#
# Table name: campaign_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  campaign_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class CampaignUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  after_create :generate_tracking_pixel

  def generate_tracking_pixel
    TrackingPixel.create!(campaign_id: self.campaign_id, user_id: self.user_id)
  end
end
