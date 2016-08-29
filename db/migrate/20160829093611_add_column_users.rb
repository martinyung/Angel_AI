class AddColumnUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :suicidal_index, :float
  end
end
