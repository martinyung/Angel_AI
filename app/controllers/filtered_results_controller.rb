class FilteredResultsController < ApplicationController 


	def index
		@all_tweets_object = Tweet.all
		@all_tweets = []
		@all_tweets_object.each do |tweet|
			@all_tweets << tweet.text
		end
		
	end

	def create

		@negative_tweets_array = []
		User.all.each do |user|
			@negative_tweets = user.tweets.where(polarity: ":(")
			@negative_tweets.each do |tweet|
				@negative_tweets_array << tweet.text
			end
				if @negative_tweets_array
					@result = Monkeylearn.classifiers.classify('cl_Y8MidxpP', @negative_tweets_array, sandbox: true)
				end
				i = 0
				@negative_tweets.each do |tweet|
				FilteredResult.create(tweet_id: tweet.id, label: @result.result[i].first["label"], probability: @result.result[i].first["probability"])
				i += 1
			end
		end
		get_suicidal_count
		
	end


	def get_suicidal_count
		User.all.each do |user|
			count = 0
			probability = 0
			user.tweets.where(polarity: ":(").each do |tweet|
				if tweet.filtered_result.label == "suicidal"
					count += 1
					probability += tweet.filtered_result.probability
				end
			end
			count
			average = probability / count
			user.update(suicidal_tweet_count: count, suicidal_tweets_probability_average: average)
		end
byebug
	end


end
