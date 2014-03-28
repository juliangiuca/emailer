class RenameToContacts < ActiveRecord::Migration
  def change
    rename_table("contacts_groups", "memberships")
  end
end
