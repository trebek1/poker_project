class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 

def hand_results (hand,index,player)
	
		max=0
		hand.chars.each_with_index do |card, char|
			# Go through each card and add to a hash for analysis 
			if  	@info[card] == nil
					@info[card] = 1
			else
					@info[card]+=1
			end   

			if char %2 == 0  # First character is the number (starting index 0)

				# find max high card 
				if card == 'A' # Make all cards comparable values including facecards 
					max = 14
				elsif card == 'K'
					value = 13
					if value > max 
						max = value 
					end 
				elsif card == 'Q'
					value = 12 
					if value > max 
						max = value 
					end 
				elsif card == 'J'
					value = 11
					if value > max 
						max = value 
					end 
				elsif card == 'T'
					value = 10
					if value > max 
						max = value 
					end 
				else 
					value = card.to_i
					if value > max 
						max = value 
					end 
				end
				
			end
			#After the last card, push max to the array 
			if char == 9
				@info['max'] = max
			end
		end
	end 
  protect_from_forgery with: :exception
end
