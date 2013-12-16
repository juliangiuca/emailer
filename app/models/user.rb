# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :tracking_pixels
  has_many :campaign_users, dependent: :destroy
  has_many :campaigns, through: :campaign_users

  validates_presence_of :email
  validates_uniqueness_of :email
end
