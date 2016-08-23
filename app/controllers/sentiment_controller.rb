class SentimentController < ApplicationController

	 def show

	 end

	 def index
	 	User.all.each do |user|
	 		user.tweets.where(polarity: ":)").average(polarity_confidence)
	 		
	 	end

	 end


end
