class RejigTheViewsTable < ActiveRecord::Migration
  def change

    rename_table    :user_agents, :views
    add_column      :views, :time, :integer, default: 0
    add_column      :views, :googled, :boolean, default: false
    remove_columns  :tracking_pixels, :views, :time_viewed

  end
end
