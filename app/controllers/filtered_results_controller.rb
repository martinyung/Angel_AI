class FilteredResultsController < ApplicationController 

	def index
	end

	def create
		@negative_tweets_array = []
		User.all.each do |user|
			@negative_tweets = user.tweets.where(polarity: ":(")
			@negative_tweets.each do |tweet|
				@negative_tweets_array << tweet.text # getting negative tweets by this user
			end

			if @negative_tweets_array
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
					average = @probability / @suicidal_count
					user.update(suicidal_tweet_count: @suicidal_count, suicidal_tweets_probability_average: average)
				else
					user.update(suicidal_tweet_count: @suicidal_count, suicidal_tweets_probability_average: 0)
				end
			end
		end
		redirect_to '/'
	end
end
