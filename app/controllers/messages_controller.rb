class MessagesController < ApplicationController
	before_action :require_login

  def show
    @message = Message.find(params[:id])
    if @message.read_at.nil? && current_user = @message.recipient
      @message.mark_as_read!
    end
  end

  def new
    load_user
  	@message = Message.new
    @friends = @user.friendships.all
  end

  def create
    load_user
  	@message = @user.sent_messages.build(messages_params)
  	if @message.save
  		flash.now[:success] = "sent message success!"
      redirect_to sent_path
  	else
  		flash.now[:warning] = "sent message fail!"
  	end
  end

  def inbox
  	load_user
    @messages = @user.latest_received_messages(50)
  end

  def sent
    load_user
    @messages = @user.latest_sent_messages(50)
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

private
  def messages_params
  	params.require(:message).permit(:body, :recipient_id)
  end
end
