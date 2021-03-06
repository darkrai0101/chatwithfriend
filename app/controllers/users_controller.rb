class UsersController < ApplicationController
  before_action :require_login, :only => [:index]
  before_action :skip_if_logged_in, :only => [:create, :new]

  def index
    @users = User.all_except(current_user)
  end

  def list
    @users = User.all
  end

  def friend
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def new
  	@user = User.new
  end

  def create
    @check = User.where(username: users_params[:username]).first
    if !@check.nil?
      flash[:danger] = "username is not avaiable!"
      # flash[:color] = "valid"
      render "new"
    else
    	@user = User.new(users_params)
    	if @user.save
    	  flash[:success] = "You are signup successfully"
    	  # flash[:color] = "valid"
        redirect_to login_path
    	else
    	  flash.now[:danger] = "Form is invalid"
    	  # flash[:color] = "invalid"  	  
        render "new"
    	end
    end
  end

private
  def users_params
  	params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
