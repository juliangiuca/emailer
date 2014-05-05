class AddSentOnToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :sent_on, :timestamp
    remove_column :emails, :sent
  end
end
