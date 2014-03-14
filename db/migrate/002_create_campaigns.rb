class CreateCampaigns < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :campaigns
  end
end

