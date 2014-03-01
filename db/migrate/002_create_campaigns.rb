Sequel.migration do
  up do
    create_table :campaigns do |t|
      String :name
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :campaigns
  end
end

