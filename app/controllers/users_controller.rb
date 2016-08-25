class UsersController < ApplicationController
	before_action :set_twitter_client

	def get_user
		@get_user = @twitter.search("die suicide kill", geocode:"#{1.3521},#{103.8198},#{100}km", lang:"en").take(10)
	end


	def create
		@users = get_user
		@users.each do |user|
			User.find_or_create_by(screen_name: user.user.screen_name, twitter_user_id: user.user.id)
		end
		redirect_to users_path
	end


	def index
		@users = get_user
	end



	def show 
			@user = User.find(params[:id])

	end





	private
	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end

end
