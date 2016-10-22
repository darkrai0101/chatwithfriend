class FriendshipsController < ApplicationController
	before_action :require_login

  def create
  	@friendship = current_user.add_friend(params[:friend_id])
  	if !@friendship.nil? && @friendship.save
  		flash[:notice] = "add friend success"
  		redirect_to root_path
  	else
  		flash[:error] = "add friend fail"
  	end
  end

  def destroy  	
    current_user.remove_friend(params[:friend_id])
  	flash[:notice] = "deleted friend"
  	redirect_to users_path
  end
end
