class AddGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :user_id
      t.string :name
      t.timestamps
    end

    create_table :contacts_groups do |t|
      t.integer :group_id
      t.integer :contact_id
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts_groups
    drop_table :groups
  end
end
