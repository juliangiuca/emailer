class RemoveCampaignUsers < ActiveRecord::Migration
  def self.up
    drop_table :campaign_users
  end

  def self.down
    create_table :campaign_users do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.timestamps
    end
  end
end


