class StaticController < ApplicationController
	before_action :require_login,  only: [:index]
	def index
	end

	private
	def require_login
		unless logged_in?
			flash[:alert] = "You must be logged in to access this section"
			redirect_to '/signup'
		end
	end
end
