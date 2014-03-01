Sequel.migration do
  up do
    create_table :tracking_pixels do |t|
      String :tracking
      Integer :user_id
      Integer :campaign_id
      DateTime :created_at
      DateTime :updated_at
    end

  end

  down do
    drop_table :tracking_pixels
  end
end

