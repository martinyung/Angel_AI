class TweetsController < ApplicationController
	before_action :set_twitter_client

	def get_tweets
		set_user		
		x = @twitter.user_timeline(@user.twitter_user_id.to_i)
		last_id = x.last.id  
		prev_id = 0
		@tweets =[]
		i =1
		while i <= 30 do
			@tweets << @twitter.user_timeline(@user.twitter_user_id.to_i , max_id: last_id)
	    	prev_id = last_id
	    	last_id = @tweets.last.last.id
	    	i+=1
		end
		return @tweets << x
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