class AddCampaignUsers < ActiveRecord::Migration
  def up
    create_table :campaign_users do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.timestamps
    end
  end

  def down
    drop_table :campaign_users
  end
end

