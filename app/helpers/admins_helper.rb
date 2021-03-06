module AdminsHelper
	def current_user
		@current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
	end

	def logged_in?
		!current_user.nil?
	end

end
