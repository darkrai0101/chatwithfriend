class FriendshipsController < ApplicationController
	before_action :require_login

  def create
  	@friendship = current_user.add_friend(params[:friend_id])
  	if !@friendship.nil? && @friendship.save
  		flash[:success] = "add friend success!"
  		redirect_to users_path
  	else
  		flash[:danger] = "add friend fail"
  	end
  end

  def destroy  	
    current_user.remove_friend(params[:friend_id])
  	flash[:success] = "remov friend success!"
  	redirect_to friend_path
  end

  def block
    current_user.block_friend(params[:friend_id])
    flash[:success] = "block friend success!"
    redirect_to friend_path
  end

  def unblock
    current_user.unblock_friend(params[:friend_id])
    flash[:success] = "unblock friend success!"
    redirect_to friend_path
  end
end
