# == Schema Information
#
# Table name: tracking_pixels
#
#  id                :integer          not null, primary key
#  tracking          :string(255)
#  contact_id        :integer
#  email_id          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  views             :integer          default(0)
#  date_first_viewed :datetime
#  sent              :datetime
#  time_viewed       :integer          default(0)
#

class TrackingPixel < ActiveRecord::Base
  belongs_to :email
  belongs_to :contact

  validates_uniqueness_of :tracking, allow_nil: true
  validates_uniqueness_of :contact_id, scope: :email_id, allow_nil: true
  validates_presence_of :contact_id
  validates_presence_of :email_id

  def self.generate_token(options={})
    TrackingPixel.create!(
      options.merge({
        tracking: SecureRandom.urlsafe_base64,
      })
    )
  end

end
