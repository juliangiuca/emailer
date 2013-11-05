class AddUsedToTrackingPixel < ActiveRecord::Migration
  def self.up
    add_column :tracking_pixels, :views, :integer, default: 0
    add_column :tracking_pixels, :date_first_viewed, :datetime
    add_column :tracking_pixels, :sent, :datetime
    add_column :campaigns, :sent, :bool
  end

  def self.down
    remove_column :campaigns, :sent
    remove_column :tracking_pixels, :sent
    remove_column :tracking_pixels, :date_first_viewed
    remove_column :tracking_pixels, :views
  end
end


