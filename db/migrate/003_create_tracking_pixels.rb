class CreateTrackingPixels < ActiveRecord::Migration
  def up
    create_table :tracking_pixels do |t|
      t.string :tracking
      t.integer :user_id
      t.integer :campaign_id
      t.timestamps
    end

  end

  def down
    drop_table :tracking_pixels
  end
end

