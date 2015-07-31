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
		# initialize combos in object for given hand 
		@info['pair']  = 0   # make value = 20 
		@info['3kind'] = 0   # make value = 50
		@info['straight'] = 0 # make value = 100
		@info['flush'] = 0   # make value = 200 
		@info['house'] = 0 # make value = 300
		@info['4kind'] = 0 # make value = 400
		@info['sflush'] = 0 # make value = 500
		@info['Royal'] = 0 # make value = 600

		# initialize max to save the best combination from the hand 
		@top = 0
		# initialize variable to save the name for the winning hand 
		@actual = []
		# test for whether or not the hand has a combo 
		@info.each do |key,val|
			# since we are only looking at the key once we could have either a pair or 3 of a kind 
			if @info[key] ==2 || @info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if @info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					@info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @top < 50
						@top = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif @info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					@info['pair'] +=1
					# see if pair is best hand, if so, set max to value 
					if @top < 20* @info['pair']
						@top = 20*@info['pair']
					end 
				end
			end 
			# find 4 of a kind without triggering 4 of a kind on a suit count
			if @info[key] ==4 && key!= 'H' && key!= 'S' && key!='D' && key!='C' && key!= 'max' 
				@info['4kind'] = 1
				@top = 400 
			end
			
			# if all five cards are in a row we have a straight 
			
			if 		  @info['A'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 ||
					  @info['6'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['Q'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['Q'] == 1 && @info['K'] == 1 && @info['9'] == 1 && @info['T'] ==1
				@info['straight'] =1
				@top = 100 	
			end

			#if all five cards are one suit we have a flush 
			if @info[key] == 5 && (key == 'H' || key == 'S' || key = 'D' || key = 'C' )
				# if those five cards are the highest five we have royal flush
				if @info['K'] == 1 && @info['Q'] == 1 && @info['J'] == 1 && @info['A'] == 1 && @info['T'] == 1 
				@info['Royal'] = 1
				@top = 600
				#if those 5 cards are not the highest, but are in order we have a straight flush 
				elsif @info['A'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 ||
					  @info['6'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['4'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['5'] ==1 || 
					  @info['6'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['7'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['Q'] == 1 && @info['8'] == 1 && @info['9'] == 1 && @info['T'] ==1 || 
					  @info['J'] == 1 && @info['Q'] == 1 && @info['K'] == 1 && @info['9'] == 1 && @info['T'] ==1
				@info['sflush'] = 1	
				@top = 500
				else 
				#if the cards are just the same color but not in order we have a regular flush 
				@info['flush'] = 1 
				@top = 200		 
				end	
			end 	
			# if we have both a 3 of a kind and a pair we have a full house 
			if @info['3kind'] == 1 && @info['pair'] == 1
			   @info['house'] = 1
			   @top = 300
			end 	
		end

		# add hand outcomes to @eachinfo at the index position in the array 
		if @info['max'] > @top
			@top = @info['max']
		end 
	# calculate the actual name for the winning hand from numerical value 

	    	if @top < 20
	    		@actual.push("High Card")
	    	elsif @top == 20
	    		@actual.push("A Pair")
	    	elsif @top == 40
	    		@actual.push("Two Pair")
	    	elsif @top == 50
	    		@actual.push("Three of a Kind")
	    	elsif @top == 100
	    		@actual.push("A Straight")
	    	elsif @top == 200 
	    		@actual.push("A Flush")
	    	elsif @top == 300
	    		@actual.push("A Full House")
	    	elsif @top == 400 
	    		@actual.push("Four of a Kind")
	    	elsif @top == 500 
	    		@actual.push("A Straight Flush")
	    	else 
	    		@actual.push("A Royal Flush")
	    	end 

	    # save the info to the index of the array of hands 
		@eachinfo[index] = @info
		
		
		if player == 1
			# objects passe by reference while numbers are not 
			@player1hands = @eachinfo.dup
			@top1[index] = @top
			@best1[index] = @actual.dup

		elsif player == 2  
			@player2hands = @eachinfo.dup
			@top2[index] = @top
			@best2[index] = @actual.dup
		end # Ends loop for hand[i]

		#initialize a new hash for the next loop
		@info = Hash.new

	end # ends loop for function 
  protect_from_forgery with: :exception
end
