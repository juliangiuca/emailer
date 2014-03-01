Sequel.migration do
  def change
    add_column :campaigns, :body, String, text: true
  end
end
