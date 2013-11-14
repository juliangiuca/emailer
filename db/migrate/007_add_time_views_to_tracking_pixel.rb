class AddTimeViewsToTrackingPixel < ActiveRecord::Migration
  def self.up
    add_column :tracking_pixels, :time_viewed, :integer, default: 0
  end

  def self.down
    remove_column :tracking_pixels, :time_viewed
  end
end


