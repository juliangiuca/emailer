Sequel.migration do
  up do
    create_table :campaign_users do |t|
      Integer :user_id
      Integer :campaign_id
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :campaign_users
  end
end

