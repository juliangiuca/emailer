class AddEmailsRemoveCampaigns < ActiveRecord::Migration
  def up
    rename_table :campaigns, :emails
    add_column :emails, :user_id, :integer

    rename_column :tracking_pixels, :user_id, :contact_id
    rename_column :tracking_pixels, :campaign_id, :email_id
  end

  def down
    rename_column :tracking_pixels, :email_id, :campaign_id
    rename_column :tracking_pixels, :contact_id, :user_id

    remove_column :emails, :user_id
    rename_table :emails, :campaigns
  end
end


