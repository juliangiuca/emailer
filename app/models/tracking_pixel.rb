# == Schema Information
#
# Table name: tracking_pixels
#
#  id                :integer          not null, primary key
#  tracking          :string(255)
#  user_id           :integer
#  campaign_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  views             :integer          default(0)
#  date_first_viewed :datetime
#  sent              :datetime
#  time_viewed       :integer          default(0)
#

class TrackingPixel < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
  has_many :user_agents

  validates_uniqueness_of :tracking, allow_nil: true
  validates_presence_of :user_id
  validates_presence_of :campaign_id

  def self.generate_tokens(options={})
    TrackingPixel.create!(
      options.merge({
        tracking: SecureRandom.urlsafe_base64,
      })
    )
  end

end
