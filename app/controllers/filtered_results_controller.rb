class FilteredResultsController < ApplicationController 


	def index
		@all_tweets_object = Tweet.all
		@all_tweets = []
		@all_tweets_object.each do |tweet|
			@all_tweets << tweet.text
		end
		@result = Monkeylearn.classifiers.classify('cl_Y8MidxpP', @all_tweets, sandbox: true)
	
	end

	def create
	end




end
