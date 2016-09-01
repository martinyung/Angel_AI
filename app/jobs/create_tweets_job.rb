require 'sentimentalizer'

class CreateTweetsJob < ApplicationJob
  queue_as :default

  def perform(user_id, text, tweet_id)

  	result = Sentimentalizer.analyze(text)
    Tweet.create(user_id: user_id, text: text, twitter_tweet_id: tweet_id, polarity: result.sentiment, polarity_confidence: result.overall_probability)
  end
end
