class User < ApplicationRecord
	has_secure_password
	has_many :messages, :foreign_key => :sender_id

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
end
