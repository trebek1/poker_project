class Array
	  def mode # Mode defined for use in calculations regarding combinations 
	    sort_by {|i| grep(i).length }.last
	  end
	end	