class TweetsController < ApplicationController
	before_action :set_twitter_client

	def create
		if logged_in?
			User.all.each do |user|
				@tweets = get_tweets(user.id)
				@tweets.each do |tweet|
					# analyse the sentiment of each tweet
					result = Sentimentalizer.analyze(tweet.full_text)
					# prevent duplicate tweets being store in database
					user.tweets.find_or_create_by(text: tweet.full_text, twitter_tweet_id: tweet.id, polarity: result.sentiment, polarity_confidence: result.overall_probability)
				end
			end
			redirect_to '/users'
		else
			flash[:alert] = "You are not logged in" 
			redirect_to '/signup'
		end	
	end

	def index
	end

	def show
	end

	private

	def get_tweets(id)
		@user = User.find(id)		
		x = @twitter.user_timeline(@user.twitter_user_id.to_i)
		last_id = x.last.id  
		@tweets = []
		@tweets << x
	
		# looping through tweets to get more than 200 tweets per query
		i = 1
		while i <= 1 do
			@tweets << @twitter.user_timeline(@user.twitter_user_id.to_i , max_id: last_id)
	    	last_id = @tweets.last.last.id
	    	i += 1
		end
		return @tweets.flatten
	end

	# def set_user
	# 	@user = User.find(params[:user_id])
	# end

	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end