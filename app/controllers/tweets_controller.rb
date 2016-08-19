class TweetsController < ApplicationController
	before_action :set_twitter_client

	def get_tweets
		@get_tweets = @twitter.search("die murder").take(3)
	end

	def index
		@tweets = get_tweets
	end


	private
	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end