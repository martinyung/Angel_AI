class UsersController < ApplicationController
	before_action :set_twitter_client

	def get_user
		@get_user = @twitter.search("suicide" "squad",lang:"en").take(1)
	end


	def create
		@users = get_user
		@users.each do |user|
			User.create(screen_name: user.user.screen_name, twitter_user_id: user.user.id)
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
