# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  body       :text
#  sent       :boolean
#  user_id    :integer
#

class Email < ActiveRecord::Base
  belongs_to :user

  has_many :tracking_pixels
  has_many :recipients, through: :tracking_pixels, source: :contact

  def deliver!
    Resque.enqueue(EmailJob, self.id)
  end
end
