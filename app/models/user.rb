# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email_address    :string(255)
#  first_name       :string(255)
#  last_name        :string(255)
#  uid              :string(255)
#  refresh_token    :string(255)
#  token            :string(255)
#  token_expires_at :datetime
#  image            :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :emails
  has_many :contacts
  has_many :groups

  validates_presence_of :email_address
  validates_uniqueness_of :email_address
  validates_uniqueness_of :uid

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.where(uid: auth_hash[:uid]).first
    user ||= User.new(uid: auth_hash[:uid])

    ### User Info ###
    info               = auth_hash[:info]

    user.first_name    = info[:first_name]
    user.last_name     = info[:last_name]
    user.email_address = info[:email]
    user.image         = info[:image]

    ### Credentials ###
    credentials                  = auth_hash[:credentials]

    user.access_token            = credentials[:token]
    user.refresh_token           = credentials[:refresh_token]
    user.access_token_expires_at = Time.at(credentials[:expires_at])
    user.expires                 = credentials[:expires]

    user.save! if user.changed?
    user
  end

end
