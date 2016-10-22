class User < ApplicationRecord
	has_secure_password
	has_many :messages, :foreign_key => :sender_id
	has_many :friendships, :foreign_key => "user_id"
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	scope :all_except, ->(user) { where.not(id: (user.friends + user.inverse_friends + [user]).map(&:id))}

	def received_messages
		Message.where(recipient: self)
	end

	def sent_messages
		messages(sender: self)
	end

	def latest_received_messages(n)
	    received_messages.order(created_at: :desc).limit(n)
	end

	def latest_sent_messages(n)
	    Message.where(sender: self).order(created_at: :desc).limit(n)
	end

	def unread_messages
		received_messages.unread.order(created_at: :desc)
	end	

	def add_friend(friend_id)
		if Friendship.between(self.id, friend_id).present?
			# 
		else
			friendships.build(:friend_id => friend_id)
		end
	end

	def remove_friend(friend_id)
		@friendship = Friendship.between(self.id, friend_id)
		@friendship.destroy_all
	end
end
