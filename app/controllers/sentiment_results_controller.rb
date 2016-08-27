class SentimentResultsController < ApplicationController 
	before_action :require_login,  only: [:index, :create, :show]

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

	private
	def require_login
		unless logged_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/signup'
		end
	end

end
