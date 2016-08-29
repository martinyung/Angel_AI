class AddColumnUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :suicidal_index, :integer
  end
end
