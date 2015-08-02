class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  	# note that each time the function runs, we are only looking at one hand, with one index and one player 
  	class Array
	  def mode # Mode defined for use in calculations regarding combinations 
	    sort_by {|i| grep(i).length }.last
	  end
	end

	def hand_results (hand,index,player)
		
		max=0 # Set the max value to zero in order to help find the high card for the hand 

		# create an array to store the values of each card in a hand 
		vals = Array.new
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
					vals.push 14 
				elsif card == 'K'
					value = 13
					vals.push 13 
					if value > max 
						max = value 
					end 
				elsif card == 'Q'
					value = 12 
					vals.push 12
					if value > max 
						max = value 
					end 
				elsif card == 'J'
					vals.push 11 
					value = 11
					if value > max 
						max = value 
					end 
				elsif card == 'T'
					value = 10
					vals.push 10
					if value > max 
						max = value 
					end 
				else 
					value = card.to_i
					vals.push value 
					if value > max 
						max = value 
					end 
				end
			end
			#After the last card, push max to the array 
			if char == 9
				@info['max'] = max
				@info['vals'] = vals 
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
		@info['pairvals'] = Array.new 

		# initialize max to save the best combination from the hand 
		@top = 0
		# initialize variable to save the name for the winning hand 
		@actual = []
		# test for whether or not the hand has a combo an set it a numerical value for comparison
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
					@info['pairvals'].push key.to_i 
					# see if pair is best hand, if so, set max to value 
					if @top < 20*@info['pair']
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
			if 	  @info['A'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1 ||
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
			if @info[key] == 5 && (key == 'H' || key == 'S' || key == 'D' || key == 'C' )
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
		end # end loop, now a whole hand has been evaluated 

		# Once the whole hand has been evaluated, if there are no combos then max should be zero
		# make max equal to the high card 
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
			# objects passed by reference while numbers are not 
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

	def tie_winner 
		# Store the winner information if there is a tie for player 1 and 2 
		@tie1 = Array.new
		@tie2 = Array.new

		for i in 0..@top1.length-1 do 

			if @top1[i] == @top2[i]

				# This cannot happen but included to be complete 
				if @best1[i][0] == "A Royal Flush"
					@tie1[i] = 0 
					@tie[i] = 0 
				end 

				if @best1[i][0] == "A Straight Flush"
					if @player1hands[i]['vals'].sort[-1] > @player2hands[i]['vals'].sort[-1]
						@tie1[i] = @player1hands[i]['vals'].sort[-1]
						@tie2[i] = 0 
					elsif @player1hands[i]['vals'].sort[-1] < @player2hands[i]['vals'].sort[-1]
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['vals'].sort[-1]
					end 
				end

				if @best1[i][0] == "Four of a Kind"
					if @player1hands[i]['vals'].mode > @player2hands[i]['vals'].mode
						@tie1[i] = @player1hands[i]['vals'].mode
						@tie2[i] = 0 
					elsif @player1hands[i]['vals'].mode < @player2hands[i]['vals'].mode
				  		@tie1[i] = 0
				  		@tie2[i] = @player2hands[i]['vals'].mode
				  	end 
				end 

				if @best1[i][0] == "Three of a Kind"
					if @player1hands[i]['vals'].mode > @player2hands[i]['vals'].mode
						@tie1[i] = @player1hands[i]['vals'].mode
						@tie2[i] = 0 
					elsif @player1hands[i]['vals'].mode < @player2hands[i]['vals'].mode
				  		@tie1[i] = 0
				  		@tie2[i] = @player2hands[i]['vals'].mode
				  	end 
				end 

				if @best1[i][0] == "A Full House"
					if @player1hands[i]['vals'].mode > @player2hands[i]['vals'].mode
						@tie1[i] = @player1hands[i]['vals'].mode
						@tie2[i] = 0 
					elsif @player1hands[i]['vals'].mode < @player2hands[i]['vals'].mode
				  		@tie1[i] = 0
				  		@tie2[i] = @player2hands[i]['vals'].mode
				  	end 
				end 

				if @best1[i][0] == "A Flush"
					if @player1hands[i]['max'] > @player2hands[i]['max'] 
						@tie1[i] = @player1hands[i]['max']
						@tie2[i] = 0
					elsif @player1hands[i]['max'] < @player2hands[i]['max']   
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['max']
					end 
				end 

				if @best1[i][0] == "A Straight"
					if @player1hands[i]['max'] > @player2hands[i]['max'] 
						@tie1[i] = @player1hands[i]['max']
						@tie2[i] = 0
					elsif @player1hands[i]['max'] < @player2hands[i]['max']   
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['max']
					end 
				end 

				if @best1[i][0] == "High Card"
					if @player1hands[i]['vals'].sort[-1] > @player2hands[i]['vals'].sort[-1]
						@tie1[i] = @player1hands[i]['vals'].sort[-1]
						@tie2[i] = 0
					elsif @player1hands[i]['vals'].sort[-1] < @player2hands[i]['vals'].sort[-1]
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['vals'].sort[-1]
					elsif @player1hands[i]['vals'].sort[-1] == @player2hands[i]['vals'].sort[-1]
						if @player1hands[i]['vals'].sort[-2] > @player2hands[i]['vals'].sort[-2]
							@tie1[i] = @player1hands[i]['vals'].sort[-2]
							@tie2[i] = 0
						elsif @player1hands[i]['vals'].sort[-2] < @player2hands[i]['vals'].sort[-2]
							@tie1[i] = 0
							@tie2[i] = @player2hands[i]['vals'].sort[-2]
						elsif @player1hands[i]['vals'].sort[-2] == @player2hands[i]['vals'].sort[-2]
							if @player1hands[i]['vals'].sort[-3] > @player2hands[i]['vals'].sort[-3]
								@tie1[i] = @player1hands[i]['vals'].sort[-3]
								@tie2[i] = 0
							elsif @player1hands[i]['vals'].sort[-3] < @player2hands[i]['vals'].sort[-3]
								@tie1[i] = 0
								@tie2[i] = @player2hands[i]['vals'].sort[-3]
							elsif @player1hands[i]['vals'].sort[-3] == @player2hands[i]['vals'].sort[-3]
								if @player1hands[i]['vals'].sort[-4] > @player2hands[i]['vals'].sort[-4]
									@tie1[i] = @player1hands[i]['vals'].sort[-4]
									@tie2[i] = 0
								elsif @player1hands[i]['vals'].sort[-4] < @player2hands[i]['vals'].sort[-4]
									@tie1[i] = 0
									@tie2[i] = @player2hands[i]['vals'].sort[-4]
								elsif @player1hands[i]['vals'].sort[-4] == @player2hands[i]['vals'].sort[-4]
									if @player1hands[i]['vals'].sort[-5 ] > @player2hands[i]['vals'].sort[-5]
										@tie1[i] = @player1hands[i]['vals'].sort[-5]
										@tie2[i] = 0
									elsif @player1hands[i]['vals'].sort[-5] < @player2hands[i]['vals'].sort[-5]
										@tie1[i] = 0
										@tie2[i] = @player2hands[i]['vals'].sort[-5]
									end
								end
							end
						end
					end
				end
			
				if @best1[i][0] == "Two Pair"    
					if @player1hands[i]['pairvals'].sort[-1] > @player2hands[i]['pairvals'].sort[-1]
						@tie1[i] = @player1hands[i]['pairvals'].sort[-1]
						@tie2[i] = 0
					elsif @player1hands[i]['pairvals'].sort[-1] < @player2hands[i]['pairvals'].sort[-1]
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['pairvals'].sort[-1]
					elsif @player1hands[i]['pairvals'].sort[-1] == @player2hands[i]['pairvals'].sort[-1]
						if @player1hands[i]['pairvals'].sort[-2] > @player2hands[i]['pairvals'].sort[-2]
							@tie1[i] = @player1hands[i]['pairvals'].sort[-2]
							@tie2[i] = 0
						elsif @player1hands[i]['pairvals'].sort[-2] < @player2hands[i]['pairvals'].sort[-2]
							@tie1[i] = 0
							@tie2[i] = @player2hands[i]['pairvals'].sort[-2]
						elsif @player1hands[i]['pairvals'].sort[-2] == @player2hands[i]['pairvals'].sort[-2]
							if @player1hands[i]['vals'].sort[-1] > @player2hands[i]['vals'].sort[-1]
								@tie1[i] = @player1hands[i]['vals'].sort[-1]
								@tie2[i] = 0
							elsif @player1hands[i]['vals'].sort[-1] < @player2hands[i]['vals'].sort[-1]
								@tie1[i] = 0
								@tie2[i] = @player2hands[i]['vals'].sort[-1]
							elsif @player1hands[i]['vals'].sort[-1] == @player2hands[i]['vals'].sort[-1]
								if @player1hands[i]['vals'].sort[-2] > @player2hands[i]['vals'].sort[-2]
									@tie1[i] = @player1hands[i]['vals'].sort[-2]
									@tie2[i] = 0
								elsif @player1hands[i]['vals'].sort[-2] < @player2hands[i]['vals'].sort[-2]
									@tie1[i] = 0
									@tie2[i] = @player2hands[i]['vals'].sort[-2]
								elsif @player1hands[i]['vals'].sort[-2] == @player2hands[i]['vals'].sort[-2]
									if @player1hands[i]['vals'].sort[-3] > @player2hands[i]['vals'].sort[-3]
										@tie1[i] = @player1hands[i]['vals'].sort[-3]
										@tie2[i] = 0
									elsif @player1hands[i]['vals'].sort[-3] < @player2hands[i]['vals'].sort[-3]
										@tie1[i] = 0
										@tie2[i] = @player2hands[i]['vals'].sort[-3]
									end 
								end
							end
						end
					end
				end  

				if @best1[i][0] == "A Pair"
					if @player1hands[i]['pairvals'][0] > @player2hands[i]['pairvals'][0]
						@tie1[i] = @player1hands[i]['pairvals'][0]
						@tie2[i] = 0
					elsif @player1hands[i]['pairvals'][0] < @player2hands[i]['pairvals'][0]
						@tie1[i] = 0
						@tie2[i] = @player2hands[i]['pairvals'][0]
					elsif @player1hands[i]['pairvals'][0] == @player2hands[i]['pairvals'][0]
						if @player1hands[i]['vals'].sort[-1] > @player2hands[i]['vals'].sort[-1]
							@tie1[i] = @player1hands[i]['vals'].sort[-1]
							@tie2[i] = 0
						elsif @player1hands[i]['vals'].sort[-1] < @player2hands[i]['vals'].sort[-1]
							@tie1[i] = 0
							@tie2[i] = @player2hands[i]['vals'].sort[-1]
						elsif @player1hands[i]['vals'].sort[-1] == @player2hands[i]['vals'].sort[-1]
							if @player1hands[i]['vals'].sort[-2] > @player2hands[i]['vals'].sort[-2]
								@tie1[i] = @player1hands[i]['vals'].sort[-2]
								@tie2[i] = 0
							elsif @player1hands[i]['vals'].sort[-2] < @player2hands[i]['vals'].sort[-2]
								@tie1[i] = 0
								@tie2[i] = @player2hands[i]['vals'].sort[-2]
							elsif @player1hands[i]['vals'].sort[-2] == @player2hands[i]['vals'].sort[-2]
								if @player1hands[i]['vals'].sort[-3] > @player2hands[i]['vals'].sort[-3]
									@tie1[i] = @player1hands[i]['vals'].sort[-3]
									@tie2[i] = 0
								elsif @player1hands[i]['vals'].sort[-3] < @player2hands[i]['vals'].sort[-3]
									@tie1[i] = 0
									@tie2[i] = @player2hands[i]['vals'].sort[-3]
								elsif @player1hands[i]['vals'].sort[-3] == @player2hands[i]['vals'].sort[-3]
									if @player1hands[i]['vals'].sort[-4] > @player2hands[i]['vals'].sort[-4]
										@tie1[i] = @player1hands[i]['vals'].sort[-4]
										@tie2[i] = 0
									elsif @player1hands[i]['vals'].sort[-4] < @player2hands[i]['vals'].sort[-4]
										@tie1[i] = 0
										@tie2[i] = @player2hands[i]['vals'].sort[-4]
									end
								end
							end
						end
					end
				end 
			else 
				# if no tie, tie should be zero
				@tie1[i] = 0
				@tie2[i] = 0
			end

		end # Ends the loop for the different types of tied hands 


	end # ends the tie function 

  protect_from_forgery with: :exception
end
