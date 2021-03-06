class TweetsController < ApplicationController
	before_action :set_twitter_client
	before_action :require_login,  only: [:index, :create]

	def create
		User.all.each do |user|
			@tweets = get_tweets(user.id)
			if user.tweets.count == 0 # new user have no tweet
				@tweets.each do |tweet|
					CreateTweetsJob.perform_later(user.id, tweet.full_text, tweet.id)
				end
			else
				@tweets.each do |tweet|
				# prevent duplicate tweets being store in database
					if user.tweets.pluck(:twitter_tweet_id).include?(tweet.id.to_s)
					else
						CreateTweetsJob.perform_later(user.id, tweet.full_text, tweet.id)
					end
				end
			end
		end
		redirect_to '/users'
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
			@tweets << @twitter.user_timeline(@user.twitter_user_id.to_i, count: 20, max_id: last_id)
	    	last_id = @tweets.last.last.id
	    	i += 1
		end
		return @tweets.flatten
	end

	def require_login
		unless logged_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/'
		end
	end

	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end