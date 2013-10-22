class User < ActiveRecord::Base
  has_many :tracking_pixels
  has_many :capaigns, through: :tracking_pixels
end
