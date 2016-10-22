class UsersController < ApplicationController
  before_action :require_login, :only => [:index]
  before_action :skip_if_logged_in, :only => [:create, :new]

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(users_params)
  	if @user.save
  	  flash[:success] = "You are signup successfully"
  	  # flash[:color] = "valid"
      redirect_to login_path
  	else
  	  flash.now[:notice] = "Form is invalid"
  	  # flash[:color] = "invalid"  	  
      render "new"
  	end
  end

private
  def users_params
  	params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
