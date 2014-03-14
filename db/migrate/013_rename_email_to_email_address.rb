class RenameEmailToEmailAddress < ActiveRecord::Migration
  def self.up
    rename_column :users, :email, :email_address
    rename_column :contacts, :email, :email_address
  end

  def self.down
    rename_column :contacts, :email_address, :email
    rename_column :users, :email_address, :email
  end
end


