class AddColumnToTweets < ActiveRecord::Migration[5.0]
  def change
  	add_column :tweets, :polarity, :string
  	add_column :tweets, :polarity_confidence, :float
  end
end
