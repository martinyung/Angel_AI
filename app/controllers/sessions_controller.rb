class SessionsController < ApplicationController
	def new
	end

	def create
		@admin = Admin.find_by(email: params[:email])
		if @admin and @admin.authenticate(params[:password])
			session[:admin_id] = @admin.id 
			redirect_to get_user_path
		else
			flash[:alert] = "Please enter a valid username or password"
			redirect_to '/login'
		end	
	end

	def destroy 
		session[:admin_id] = nil
		redirect_to '/login'
	end
end
