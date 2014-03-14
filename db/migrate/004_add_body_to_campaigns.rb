class AddBodyToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :body, :text
  end
end
