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
#

class TrackingPixel < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  validates_uniqueness_of :tracking
  validates_presence_of :user_id
  validates_presence_of :campaign_id

  def self.generate_token(options={})
    tp = TrackingPixel.new( options.merge(tracking: SecureRandom.urlsafe_base64) )
  end
end
