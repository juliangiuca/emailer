class Campaign < ActiveRecord::Base
  has_many :tracking_pixels
  has_many :users, through: :tracking_pixels
end
