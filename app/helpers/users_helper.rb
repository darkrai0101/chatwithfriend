module UsersHelper
	def friendIsBlocked(friendship)
	    @selfIsA = friendship.friend.id == current_user.id ? false : true
	    
	    if friendship.status.nil?
	    	return false
	    end

	    if friendship.status == 3
	    	return true
	    end

	    if @selfIsA && friendship.status == 1
	    	return true
	    end

	    if !@selfIsA && friendship.status == 2
	    	return true
	    end	    

	    return false
	end
end
