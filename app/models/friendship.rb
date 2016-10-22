class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => "User"

	scope :involving, ->(user) do
		where("friendships.user_id = ? or friendships.friend_id = ?", user.id, user.id)
	end

	scope :between, ->(user_id, friend_id) do
		where("(friendships.user_id = ? and friendships.friend_id = ?) or (friendships.friend_id = ? and friendships.user_id = ?)", user_id, friend_id, user_id, friend_id)
	end	
end
