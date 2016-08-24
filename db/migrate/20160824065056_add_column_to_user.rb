class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :suicidal_tweet_count, :integer
  	add_column :users, :suicidal_tweets_probability_average, :float
  end
end
