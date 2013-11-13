class AddTimeViewsToTrackingPixel < ActiveRecord::Migration
  def self.up
    add_column :tracking_pixels, :time_viewed, :integer, default: 0
    add_column :tracking_pixels, :timing, :string
  end

  def self.down
    remove_column :tracking_pixels, :timing
    remove_column :tracking_pixels, :time_viewed
  end
end


