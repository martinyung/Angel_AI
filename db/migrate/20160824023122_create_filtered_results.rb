class CreateFilteredResults < ActiveRecord::Migration[5.0]
  def change
    create_table :filtered_results do |t|
    	t.belongs_to :tweet, index: true 
    	t.text :label
    	t.float :probability
      t.timestamps
    end
  end
end
