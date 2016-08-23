class TweetsController < ApplicationController
	before_action :set_twitter_client

	def new
	end

	def create
		set_user
		@tweets = get_tweets
		@tweets.each do |tweet|
			result = Sentimentalizer.analyze(tweet.full_text)
			@user.tweets.create(text: tweet.full_text, twitter_tweet_id: tweet.id, polarity: result.sentiment, polarity_confidence: result.overall_probability)
		end
		redirect_to '/sentiment_results'
	end

	def index
		@tweets = get_tweets
	end

	def show
	end

	private

	def get_tweets
		
		set_user		
		x = @twitter.user_timeline(@user.twitter_user_id.to_i)
		last_id = x.last.id  
		@tweets = []
		@tweets << x
		@monkey = []
		i =1
		while i <= 1 do
			@tweets << @twitter.user_timeline(@user.twitter_user_id.to_i , max_id: last_id)
	    	last_id = @tweets.last.last.id
	    	@tweets.each do |tweet|
	    		tweet.each do |monkey|
	    		@monkey <<monkey.text
	    	end
	    	end
	    	i+=1
		end
		return @tweets.flatten
		# r = Monkeylearn.classifiers.classify('cl_Y8MidxpP', @monkey, sandbox: true)
		
	end


	def set_user
		@user = User.find(params[:user_id])

	end

	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end