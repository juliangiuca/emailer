# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :groups

  validates_presence_of :email_address
  validates_uniqueness_of :email_address, scope: :user_id
end
