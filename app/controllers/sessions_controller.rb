class SessionsController < ApplicationController

  def login
  end

  def login_attempt
  	if @user = User.find_by_username(params[:username])
	  	if @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
	  		flash.now[:success] = "login success!"
	  		redirect_to root_path
	  	else
	  		flash.now[:danger] = "password incorrect!"
	  		render "login"
	  	end
	else
		flash.now[:danger] = "username incorrect!"
		render "login"
	end  	
  end

  def logout
	  session[:user_id] = nil
	  redirect_to login_path
  end
end
