# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email_address :string(255)
#

class User < ActiveRecord::Base
  has_many :emails
  has_many :contacts
  has_many :groups

  validates_presence_of :email_address
  validates_uniqueness_of :email_address
end
