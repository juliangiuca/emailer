class AddUserTracking < ActiveRecord::Migration
  def self.up
    create_table :user_agents do |t|
      t.integer :tracking_pixel_id
      t.string :agent, limit: 1000
      t.string :referer, limit: 1000
      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :user_agents
  end
end


