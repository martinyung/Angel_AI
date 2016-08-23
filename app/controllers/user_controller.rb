class UserController < ApplicationController
	before_action :set_twitter_client

	def get_user
		@get_user = @twitter.search("die suicide", geocode:"#{1.3521},#{103.8198},#{100}km", lang:"en").take(100)
	end


	def create
		@get_user.each do |user|
			User.create(screen_name: user.screen_name, twitter_user_id: user.user)
		end

	end


	def index
		@tweets = get_tweets
	end



	def show 

	end





	private
	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end

end
