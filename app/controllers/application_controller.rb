class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  	# note that each time the function hand_results runs, we are only looking at one hand, with one index and one player 

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
		@hand_score = 0
		# initialize variable to save the name for the winning hand 
		@combo_name = []
		# test for whether or not the hand has a combo an set it a numerical value for comparison
		@info.each do |key,val|
			# since we are only looking at the key once we could have either a pair or 3 of a kind 
			if @info[key] ==2 || @info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if @info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					@info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @hand_score < 50
						@hand_score = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif @info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					@info['pair'] +=1
					@info['pairvals'].push key.to_i 
					# see if pair is best hand, if so, set max to value 
					if @hand_score < 20*@info['pair']
						@hand_score = 20*@info['pair']
					end 
				end
			end 
			# find 4 of a kind without triggering 4 of a kind on a suit count
			if @info[key] ==4 && key!= 'H' && key!= 'S' && key!='D' && key!='C' && key!= 'max' 
				@info['4kind'] = 1
				@hand_score = 400 
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
				@hand_score = 100 	
			end

			#if all five cards are one suit we have a flush 
			if @info['H'] == 5 || @info['S'] == 5 || @info['D'] == 5 || @info['C'] == 5 
				# if those five cards are the highest five we have royal flush
				if @info['K'] == 1 && @info['Q'] == 1 && @info['J'] == 1 && @info['A'] == 1 && @info['T'] == 1 
				@info['Royal'] = 1
				@hand_score = 600
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
				@hand_score = 500
				else 
				#if the cards are just the same color but not in order we have a regular flush 
				@info['flush'] = 1 
				@hand_score = 200		 
				end	
			end 	
			# if we have both a 3 of a kind and a pair we have a full house 
			if @info['3kind'] == 1 && @info['pair'] == 1
			   @info['house'] = 1
				if @hand_score < 300
			   		@hand_score = 300
				end
			end 	
		end # end loop, now a whole hand has been evaluated 

		# Once the whole hand has been evaluated, if there are no combos then max should be zero
		# make max equal to the high card 
		if @info['max'] > @hand_score
			@hand_score = @info['max']
		end 
		# calculate the actual name for the winning hand from numerical value 
		if @hand_score < 20
			@combo_name.push("High Card")
		elsif @hand_score == 20
			@combo_name.push("A Pair")
		elsif @hand_score == 40
			@combo_name.push("Two Pair")
		elsif @hand_score == 50
			@combo_name.push("Three of a Kind")
		elsif @hand_score == 100
			@combo_name.push("A Straight")
		elsif @hand_score == 200 
			@combo_name.push("A Flush")
		elsif @hand_score == 300
			@combo_name.push("A Full House")
		elsif @hand_score == 400 
			@combo_name.push("Four of a Kind")
		elsif @hand_score == 500 
			@combo_name.push("A Straight Flush")
		else 
			@combo_name.push("A Royal Flush")
		end 

	    # save the info to the index of the array of hands 
		@eachinfo[index] = @info
			
		if player == 1
			# objects passed by reference while numbers are not 
			@hand_information_player_1 = @eachinfo.dup
			@best_card_value_1[index] = @hand_score
			@combo_name_1[index] = @combo_name.dup
		elsif player == 2  
			@hand_information_player_2 = @eachinfo.dup
			@best_card_value_2[index] = @hand_score
			@combo_name_2[index] = @combo_name.dup
		end # Ends loop for hand[i]

		#initialize a new hash for the next loop
		@info = Hash.new

	end # ends loop for function 

	def tie_winner 
		# Store the winner information if there is a tie for player 1 and 2 
		@tie_1 = Array.new
		@tie_2 = Array.new

		for i in 0..@best_card_value_1.length-1 do 

			if @best_card_value_1[i] == @best_card_value_2[i]

				# This cannot happen but included to be complete 
				if @combo_name_1[i][0] == "A Royal Flush"
					@tie_1[i] = 0 
					@tie_2[i] = 0 
				end 
				# find winner with two straight flushes
				# larger straight flush will be the largest value in the values array
				if @combo_name_1[i][0] == "A Straight Flush"
					if @hand_information_player_1[i]['vals'].sort[-1] > @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-1]
						@tie_2[i] = 0 
					elsif @hand_information_player_1[i]['vals'].sort[-1] < @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-1]
					end 
				end
				# find winner with 2 four of a kinds
				# larger 4 of a kind will be the mode of the value array
				if @combo_name_1[i][0] == "Four of a Kind"
					if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
						@tie_1[i] = @hand_information_player_1[i]['vals'].mode
						@tie_2[i] = 0 
					elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
				  		@tie_1[i] = 0
				  		@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				  	end 
				end 
				# find winner with two three of a kinds
				# larger 3 of a kind will be the mode of the values array  
				if @combo_name_1[i][0] == "Three of a Kind"
					if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
						@tie_1[i] = @hand_information_player_1[i]['vals'].mode
						@tie_2[i] = 0 
					elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
				  		@tie_1[i] = 0
				  		@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				  	end 
				end 
				# find winner with two full houses. Larger full house will be larger 3 of a kind, 
				# which can be found as the mode of the values array 
				if @combo_name_1[i][0] == "A Full House"
					if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
						@tie_1[i] = @hand_information_player_1[i]['vals'].mode
						@tie_2[i] = 0 
					elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
				  		@tie_1[i] = 0
				  		@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				  	end 
				end 
				# find winner with two flushes. Since a flush is 5 cards, max will store largest. 
				if @combo_name_1[i][0] == "A Flush"
					if @hand_information_player_1[i]['max'] > @hand_information_player_2[i]['max'] 
						@tie_1[i] = @hand_information_player_1[i]['max']
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['max'] < @hand_information_player_2[i]['max']   
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['max']
					end 
				end 
				# find winner with two straights. Since a straight is 5 cards, the max will have 
				# the larger of the two saved 
				if @combo_name_1[i][0] == "A Straight"
					if @hand_information_player_1[i]['max'] > @hand_information_player_2[i]['max'] 
						@tie_1[i] = @hand_information_player_1[i]['max']
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['max'] < @hand_information_player_2[i]['max']   
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['max']
					end 
				end 
				# find winner with same high card. Itterate through all 5 cards until one is bigger 
				if @combo_name_1[i][0] == "High Card"
					if @hand_information_player_1[i]['vals'].sort[-1] > @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-1]
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['vals'].sort[-1] < @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-1]
					elsif @hand_information_player_1[i]['vals'].sort[-1] == @hand_information_player_2[i]['vals'].sort[-1]
						if @hand_information_player_1[i]['vals'].sort[-2] > @hand_information_player_2[i]['vals'].sort[-2]
							@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-2]
							@tie_2[i] = 0
						elsif @hand_information_player_1[i]['vals'].sort[-2] < @hand_information_player_2[i]['vals'].sort[-2]
							@tie_1[i] = 0
							@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-2]
						elsif @hand_information_player_1[i]['vals'].sort[-2] == @hand_information_player_2[i]['vals'].sort[-2]
							if @hand_information_player_1[i]['vals'].sort[-3] > @hand_information_player_2[i]['vals'].sort[-3]
								@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-3]
								@tie_2[i] = 0
							elsif @hand_information_player_1[i]['vals'].sort[-3] < @hand_information_player_2[i]['vals'].sort[-3]
								@tie_1[i] = 0
								@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-3]
							elsif @hand_information_player_1[i]['vals'].sort[-3] == @hand_information_player_2[i]['vals'].sort[-3]
								if @hand_information_player_1[i]['vals'].sort[-4] > @hand_information_player_2[i]['vals'].sort[-4]
									@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-4]
									@tie_2[i] = 0
								elsif @hand_information_player_1[i]['vals'].sort[-4] < @hand_information_player_2[i]['vals'].sort[-4]
									@tie_1[i] = 0
									@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-4]
								elsif @hand_information_player_1[i]['vals'].sort[-4] == @hand_information_player_2[i]['vals'].sort[-4]
									if @hand_information_player_1[i]['vals'].sort[-5 ] > @hand_information_player_2[i]['vals'].sort[-5]
										@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-5]
										@tie_2[i] = 0
									elsif @hand_information_player_1[i]['vals'].sort[-5] < @hand_information_player_2[i]['vals'].sort[-5]
										@tie_1[i] = 0
										@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-5]
									end
								end
							end
						end
					end
				end
				# find winner with same two pairs. First check each of the pair values (high to low) then check
				# the remaining cards high to low 
				if @combo_name_1[i][0] == "Two Pair"    
					if @hand_information_player_1[i]['pairvals'].sort[-1] > @hand_information_player_2[i]['pairvals'].sort[-1]
						@tie_1[i] = @hand_information_player_1[i]['pairvals'].sort[-1]
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['pairvals'].sort[-1] < @hand_information_player_2[i]['pairvals'].sort[-1]
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['pairvals'].sort[-1]
					elsif @hand_information_player_1[i]['pairvals'].sort[-1] == @hand_information_player_2[i]['pairvals'].sort[-1]
						if @hand_information_player_1[i]['pairvals'].sort[-2] > @hand_information_player_2[i]['pairvals'].sort[-2]
							@tie_1[i] = @hand_information_player_1[i]['pairvals'].sort[-2]
							@tie_2[i] = 0
						elsif @hand_information_player_1[i]['pairvals'].sort[-2] < @hand_information_player_2[i]['pairvals'].sort[-2]
							@tie_1[i] = 0
							@tie_2[i] = @hand_information_player_2[i]['pairvals'].sort[-2]
						elsif @hand_information_player_1[i]['pairvals'].sort[-2] == @hand_information_player_2[i]['pairvals'].sort[-2]
							if @hand_information_player_1[i]['vals'].sort[-1] > @hand_information_player_2[i]['vals'].sort[-1]
								@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-1]
								@tie_2[i] = 0
							elsif @hand_information_player_1[i]['vals'].sort[-1] < @hand_information_player_2[i]['vals'].sort[-1]
								@tie_1[i] = 0
								@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-1]
							elsif @hand_information_player_1[i]['vals'].sort[-1] == @hand_information_player_2[i]['vals'].sort[-1]
								if @hand_information_player_1[i]['vals'].sort[-2] > @hand_information_player_2[i]['vals'].sort[-2]
									@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-2]
									@tie_2[i] = 0
								elsif @hand_information_player_1[i]['vals'].sort[-2] < @hand_information_player_2[i]['vals'].sort[-2]
									@tie_1[i] = 0
									@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-2]
								elsif @hand_information_player_1[i]['vals'].sort[-2] == @hand_information_player_2[i]['vals'].sort[-2]
									if @hand_information_player_1[i]['vals'].sort[-3] > @hand_information_player_2[i]['vals'].sort[-3]
										@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-3]
										@tie_2[i] = 0
									elsif @hand_information_player_1[i]['vals'].sort[-3] < @hand_information_player_2[i]['vals'].sort[-3]
										@tie_1[i] = 0
										@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-3]
									end 
								end
							end
						end
					end
				end  
				# find winner with same pairs, first check pair value (high to low), then itterate through all remaining cards
				# high to low  
				if @combo_name_1[i][0] == "A Pair"
					if @hand_information_player_1[i]['pairvals'][0] > @hand_information_player_2[i]['pairvals'][0]
						@tie_1[i] = @hand_information_player_1[i]['pairvals'][0]
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['pairvals'][0] < @hand_information_player_2[i]['pairvals'][0]
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['pairvals'][0]
					elsif @hand_information_player_1[i]['pairvals'][0] == @hand_information_player_2[i]['pairvals'][0]
						if @hand_information_player_1[i]['vals'].sort[-1] > @hand_information_player_2[i]['vals'].sort[-1]
							@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-1]
							@tie_2[i] = 0
						elsif @hand_information_player_1[i]['vals'].sort[-1] < @hand_information_player_2[i]['vals'].sort[-1]
							@tie_1[i] = 0
							@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-1]
						elsif @hand_information_player_1[i]['vals'].sort[-1] == @hand_information_player_2[i]['vals'].sort[-1]
							if @hand_information_player_1[i]['vals'].sort[-2] > @hand_information_player_2[i]['vals'].sort[-2]
								@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-2]
								@tie_2[i] = 0
							elsif @hand_information_player_1[i]['vals'].sort[-2] < @hand_information_player_2[i]['vals'].sort[-2]
								@tie_1[i] = 0
								@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-2]
							elsif @hand_information_player_1[i]['vals'].sort[-2] == @hand_information_player_2[i]['vals'].sort[-2]
								if @hand_information_player_1[i]['vals'].sort[-3] > @hand_information_player_2[i]['vals'].sort[-3]
									@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-3]
									@tie_2[i] = 0
								elsif @hand_information_player_1[i]['vals'].sort[-3] < @hand_information_player_2[i]['vals'].sort[-3]
									@tie_1[i] = 0
									@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-3]
								elsif @hand_information_player_1[i]['vals'].sort[-3] == @hand_information_player_2[i]['vals'].sort[-3]
									if @hand_information_player_1[i]['vals'].sort[-4] > @hand_information_player_2[i]['vals'].sort[-4]
										@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-4]
										@tie_2[i] = 0
									elsif @hand_information_player_1[i]['vals'].sort[-4] < @hand_information_player_2[i]['vals'].sort[-4]
										@tie_1[i] = 0
										@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-4]
									end
								end
							end
						end
					end
				end 
			else 
				# if no tie, tie should be zero
				@tie_1[i] = 0
				@tie_2[i] = 0
			end

		end # Ends the loop for the different types of tied hands 

	end # ends the tie function 

def high_card_winner

 # find high card winner card from numerical representation
    for i in 0..@best_card_value_1.length-1 do 
      if @best_card_value_1[i] <= 10
        @high_card_winner_1[i] = @best_card_value_1[i]
      elsif @best_card_value_1[i] == 11
        @high_card_winner_1[i] = 'J'
      elsif @best_card_value_1[i] == 12
        @high_card_winner_1[i] = 'Q'
      elsif @best_card_value_1[i] == 13
        @high_card_winner_1[i] = 'K'
      elsif @best_card_value_1[i] == 14
        @high_card_winner_1[i] = "A"
      end 
      if @best_card_value_2[i]<=10
        @high_card_winner_2[i] = @best_card_value_2[i]
      elsif @best_card_value_2[i] == 11
        @high_card_winner_2[i] = 'J'
      elsif @best_card_value_2[i] == 12
        @high_card_winner_2[i] = 'Q'
      elsif @best_card_value_2[i] == 13
        @high_card_winner_2[i] = 'K'
      elsif @best_card_value_2[i] == 14
        @high_card_winner_2[i] = "A"
      end 
    end
end 


  protect_from_forgery with: :exception
end
