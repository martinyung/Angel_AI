class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
    	t.belongs_to :user
    	t.string :text
    	t.string :twitter_tweet_id

      t.timestamps
    end
  end
end
