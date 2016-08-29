class FilteredResultsController < ApplicationController 
	before_action :require_login,  only: [:index, :create]

	def index
	end

	def create
		@negative_tweets_array = []
		User.all.each do |user|
			@negative_tweets = user.tweets.where(polarity: ":(")
			@negative_tweets.each do |tweet|
				@negative_tweets_array << tweet.text # getting negative tweets by this user
			end

			if @negative_tweets_array.count > 0
				@result = Monkeylearn.classifiers.classify('cl_Y8MidxpP', @negative_tweets_array, sandbox: true)
			
				@count = 0 # negative tweet count
				@suicidal_count = 0
				@probability = 0

				@negative_tweets.each do |tweet| # iterating all negative tweets and create filtered_result and calculating suicidal count and probability. 
					FilteredResult.create_with(tweet_id: tweet.id, label: @result.result[@count].first["label"], probability: @result.result[@count].first["probability"]).find_or_create_by(tweet_id: tweet.id)

					if tweet.filtered_result.label == "suicidal" 
						@suicidal_count += 1
						@probability += tweet.filtered_result.probability
					end
					@count += 1
				end

				if @suicidal_count > 0
					tweet_count = user.tweets.count
					suicidal_count_percent = (@suicidal_count / tweet_count.to_f) * 100
					average = @probability / @suicidal_count
					suicidal_index = suicidal_count_percent * average
					user.update(suicidal_tweet_count: @suicidal_count, suicidal_tweets_probability_average: average, suicidal_index: suicidal_index)
				else
					user.update(suicidal_tweet_count: @suicidal_count, suicidal_tweets_probability_average: 0, suicidal_index: 0)
				end
			else # no negative tweets
				user.update(suicidal_tweet_count: 0, suicidal_tweets_probability_average: 0, suicidal_index: 0)
			end
		end
		redirect_to '/get_user'
	end

	def require_login
		unless logged_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/'
		end
	end

end
