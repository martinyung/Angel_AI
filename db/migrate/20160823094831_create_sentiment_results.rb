class CreateSentimentResults < ActiveRecord::Migration[5.0]
  def change
    create_table :sentiment_results do |t|
    	t.belongs_to :user, index: true
    	t.float :positive_average
    	t.float :negative_average

      t.timestamps
    end
  end
end
