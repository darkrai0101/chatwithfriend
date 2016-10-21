class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in
  helper_method :require_login
  helper_method :skip_if_logged_in
  
	def current_user
		return @current_user if @current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])
		else
		end
	end

	def signed_in
		if !session[:user_id].nil?
			return true
		else
			return false
		end
	end

	def require_login
		if !signed_in
			flash.now[:danger] = "You must sign in to see this page!"
			redirect_to login_path
		end
	end

	def skip_if_logged_in
		if signed_in
			redirect_to users_path
		end
	end
end
