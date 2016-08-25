class UsersController < ApplicationController
	before_action :set_twitter_client

	def create
		if params[:search].split.count > 0 and params[:search].split.count < 11
			@users = @twitter.search(params[:search], lang:"en").take(2)
			@users.each do |user|
				User.find_or_create_by(screen_name: user.user.screen_name, twitter_user_id: user.user.id)
			end
			redirect_to users_path
		else
			@error = "Invalid search input, please try again"
			render "static/index"
		end
		
	end

	def index
		@users
	end

	def show 
		@user = User.find(params[:id])
	end

	private

	def set_twitter_client
		@twitter = AngelAi::Application.config.twitter
	end
end
