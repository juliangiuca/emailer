class RenameNameToSubject < ActiveRecord::Migration
  def self.up
    rename_column :emails, :name, :subject
  end

  def self.down
    rename_column :emails, :subject, :name
  end
end


