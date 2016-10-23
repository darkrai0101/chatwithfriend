class Message < ApplicationRecord
	belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
	belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

	validates_presence_of :body, :sender_id, :recipient_id	

	scope :unread, -> { where(read_at: nil) }

	scope :unread_user, -> (user) do
	 	where("read_at = ? and recipient_id = ? and status = ?", nil, user.id, nil)
	end

	def mark_as_read!
		self.read_at = Time.now
		save!
	end

	def read?
		read_at
	end
end
