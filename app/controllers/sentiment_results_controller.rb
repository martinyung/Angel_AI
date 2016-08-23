class SentimentResultsController < ApplicationController



	def index
		User.all.each do |user|
	 		pos_result = user.tweets.where(polarity: ":)").average(:polarity_confidence)
	 		neg_result = user.tweets.where(polarity: ":(").average(:polarity_confidence)


	 		SentimentResult.create(user_id: user.id, positive_average: pos_result, negative_average: neg_result)

	 	end
	 	
	end


end
