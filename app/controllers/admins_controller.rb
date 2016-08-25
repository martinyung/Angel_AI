class AdminsController < ApplicationController

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.find_by(email: params[:admin][:email])
		if @admin
			if @admin.authenticate(params[:admin][:password])
				redirect_to get_user_path

			else
				flash[:alert] = "Please enter a valid username or password"
				redirect_to new_admin_path
			end	
		else	
			@admin = Admin.create(admin_params)
			redirect_to get_user_path
		end
	end

	private
	def admin_params
        params.require(:admin).permit(:name, :email, :password)		
	end
end

