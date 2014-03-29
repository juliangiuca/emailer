class AddTokensToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :uid, :string
    add_column :users, :refresh_token, :string
    add_column :users, :access_token, :string
    add_column :users, :access_token_expires_at, :datetime
    add_column :users, :expires, :boolean
    add_column :users, :image, :string
  end
end
