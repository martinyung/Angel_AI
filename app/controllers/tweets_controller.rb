class TweetsController < ApplicationController
	before_action :set_twitter_client

	def get_tweets
		set_user
		
		@tweets = @twitter.user_timeline(@user.twitter_user_id.to_i, count:200, max_id)
	end

	def new

	end

	def create
		set_user
		@tweets = get_tweets
		@tweets.each do |tweet|
		@user.tweets.create(text: tweet.full_text, twitter_tweet_id: tweet.id)
		end
		redirect_to '/'

	end

	def index
		@tweets = get_tweets
	end

	def show
	end

	private

	def set_user
		@user = User.find(params[:user_id])

	end


	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end