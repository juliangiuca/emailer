# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  email_address :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :tracking_pixels

  # validates_presence_of :email_address
  validates :email_address, presence: true
  validates_uniqueness_of :email_address, scope: :user_id
end
