class SentimentResultsController < ApplicationController 

	def index
		@all_sentiment = SentimentResult.all
	end

	def show
		@user = User.find(params[:user_id])
		@sentiment = SentimentResult.find_by(user_id: @user.id)
	end

	def create
	User.all.each do |user|
		pos_result = user.tweets.where(polarity: ":)").average(:polarity_confidence)
		neg_result = user.tweets.where(polarity: ":(").average(:polarity_confidence)
		SentimentResult.find_or_create_by(user_id: user.id, positive_average: pos_result, negative_average: neg_result)
	 	end
	 	redirect_to sentiment_results_path
	end
end
