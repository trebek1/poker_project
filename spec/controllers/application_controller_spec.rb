require "rails_helper"

RSpec.describe SimulationsController do

    it "adds a new key if one does not exist" do
    	card = 2
    	info = {}
	    if info[card] == nil
				info[card] = 1
		else
				info[card]+=1
		end   
    	expect(info[2]).to equal 1 
    end 
    it "increments value by one if card exists" do

		card = 2
		info = {2 => 1}
	    if info[card] == nil
				info[card] = 1
		else
				info[card]+=1
		end   

    	expect(info[2]).to equal 2
    end 

    it "finds the max value and assigns max for the hand to that value(face)" do
	    examplehand = '8CTSKC9H4S'
	    value = 0
	    max = 0
	    for char in 0..examplehand.length-1
		    if char %2 == 0  # First character is the number (starting index 0)
		    	card = examplehand[char]
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
		end # end for loop
 		expect(max).to equal 13
 	end # end case  	
 	
 	it "finds the max value and assigns max for the hand to that value (numeric), then stores in object" do
	    examplehand = '7C3S3C3H3S'
	    value = 0
	    max = 0
	    info = {}

	    for char in 0..examplehand.length-1
		    if char %2 == 0  # First character is the number (starting index 0)
		    	card = examplehand[char]
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
			if char == 9
				info['max'] = max
			end
		end # end for loop
	 	expect(max).to equal 7
	 	expect(info['max']).to equal 7
 	end # end case 

 	it " should test positive for a pair (and ignore the suits) and set value equal to 20" do 
	 	@hand_score = 0
 		info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>2, 'pair'=> 0}
 		info.each do |key,val|
		 	if info[key] ==2 || info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @hand_score < 50
						@hand_score = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					info['pair'] +=1
					# see if pair is best hand, if so, set max to value 
					if @hand_score < 20* info['pair']
						@hand_score = 20*info['pair']
					end 
				end	 
			end 
		end 
		expect(@hand_score).to eql 20
		expect(info['pair']).to eql 1
	end 

	it " should test positive for 2 pair (and ignore the suits) and set value equal to 40" do 
	 	@hand_score = 0
 		info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>2, '7' =>2, 'pair'=> 0}
 		info.each do |key,val|
		 	if info[key] ==2 || info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @hand_score < 50
						@hand_score = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					info['pair'] +=1
					# see if pair is best hand, if so, set max to value 
					if @hand_score < 20* info['pair']
						@hand_score = 20*info['pair']
					end 
				end	 
			end 
		end 
		expect(@hand_score).to eql 40
		expect(info['pair']).to eql 2
	end 

	it " should test positive for a 3 of a kind and set value equal to 50" do 
	 	@hand_score = 0
 		info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>3, 'pair'=> 0, '3kind' => 0}
 		info.each do |key,val|
		 	if info[key] ==2 || info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @hand_score < 50
						@hand_score = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					info['pair'] +=1
					# see if pair is best hand, if so, set max to value 
					if @hand_score < 20* info['pair']
						@hand_score = 20*info['pair']
					end 
				end	 
			end 
		end 
		expect(@hand_score).to eql 50
		expect(info['3kind']).to eql 1
	end 

	it "should test four of a kind (4kind =1 ) and set value to 400 also make sure pair is not being triggered twice" do 
		
		@hand_score = 0
 		info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>4, 'pair'=> 0, '3kind' => 0, '4kind' => 0}
		info.each do |key,val|
			if info[key] ==4 && key!= 'H' && key!= 'S' && key!='D' && key!='C' && key!= 'max' 
						info['4kind'] = 1
						@hand_score = 400 
			end
		end
			expect(@hand_score).to eql 400
			expect(info['4kind']).to eq 1
			expect(info['pair']).not_to eq 2 
	end 
	
	it "Should test that straight is triggered for a straight and assign a value of 100" do 
		@hand_score = 0
 		info = {'A' => 1, '2' => 1, '3' => 1, '4' => 1, '5' =>1, 'pair'=> 0, '3kind' => 0, '4kind' => 0, 'straight' => 0}
		
 			if    info['A'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1
				  info['6'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
				  info['6'] == 1 && info['7'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
				  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['4'] == 1 && info['5'] ==1 || 
				  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['5'] ==1 || 
				  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
				  info['J'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
				  info['J'] == 1 && info['Q'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
				  info['J'] == 1 && info['Q'] == 1 && info['K'] == 1 && info['9'] == 1 && info['T'] ==1
			info['straight'] =1
			@hand_score = 100 	
			end
		
		expect(@hand_score).to eq 100
		expect(info['straight']).to eq 1   
	end 

	it "should test for flush but not royal or straight" do 
		@hand_score = 0
			info = { 'D' => 5, '2' =>1, '4' =>3, 'pair'=> 0, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			info.each do |key,val|
		
			if info[key] == 5 && (key == 'H' || key == 'S' || key == 'D' || key == 'C' )
				# if those five cards are the highest five we have royal flush
				if info['K'] == 1 && info['Q'] == 1 && info['J'] == 1 && info['A'] == 1 && info['T'] == 1 
				info['Royal'] = 1
				@hand_score = 600
				#if those 5 cards are not the highest, but are in order we have a straight flush 
				elsif info['A'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 ||
					  info['6'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['K'] == 1 && info['9'] == 1 && info['T'] ==1
				info['sflush'] = 1	
				@hand_score = 500
				else 
				#if the cards are just the same color but not in order we have a regular flush 
				info['flush'] = 1 
				@hand_score = 200		 
				end	
			end 	
		end # ends loop for object 
		expect(info['flush']).to eq 1
		expect(@hand_score).to eq 200 
		expect(info['Royal']).to_not eq 1
		expect(info['sflush']).to_not eq 1 
	end 

	it "should test for straigh flush but not royal or regular flush" do 
		@hand_score = 0
			info = { 'D' => 5, '2' =>1, '3' =>1, '4'=> 1, '5' => 1, '6' => 1, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			info.each do |key,val|
		
			if info[key] == 5 && (key == 'H' || key == 'S' || key = 'D' || key = 'C' )
				# if those five cards are the highest five we have royal flush
				if info['K'] == 1 && info['Q'] == 1 && info['J'] == 1 && info['A'] == 1 && info['T'] == 1 
				info['Royal'] = 1
				@hand_score = 600
				#if those 5 cards are not the highest, but are in order we have a straight flush 
				elsif info['A'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 ||
					  info['6'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['K'] == 1 && info['9'] == 1 && info['T'] ==1
				info['sflush'] = 1	
				@hand_score = 500
				else 
				#if the cards are just the same color but not in order we have a regular flush 
				info['flush'] = 1 
				@hand_score = 200		 
				end	
			end 	
		end # ends loop for object 
		expect(info['sflush']).to eq 1
		expect(@hand_score).to eq 500 
		expect(info['Royal']).to_not eq 1
		expect(info['flush']).to_not eq 1 
	end 

	it "should test for royal flush but not straight or regular flush" do 
		@hand_score = 0
		info = { 'D' => 5, 'T' =>1, 'J' =>1, 'Q'=> 1, 'K' => 1, 'A' => 1, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			info.each do |key,val|
		
			if info[key] == 5 && (key == 'H' || key == 'S' || key = 'D' || key = 'C' )
				# if those five cards are the highest five we have royal flush
				if info['K'] == 1 && info['Q'] == 1 && info['J'] == 1 && info['A'] == 1 && info['T'] == 1 
				info['Royal'] = 1
				@hand_score = 600
				#if those 5 cards are not the highest, but are in order we have a straight flush 
				elsif info['A'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 ||
					  info['6'] == 1 && info['2'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['3'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['4'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['5'] ==1 || 
					  info['6'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['7'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['8'] == 1 && info['9'] == 1 && info['T'] ==1 || 
					  info['J'] == 1 && info['Q'] == 1 && info['K'] == 1 && info['9'] == 1 && info['T'] ==1
				info['sflush'] = 1	
				@hand_score = 500
				else 
				#if the cards are just the same color but not in order we have a regular flush 
				info['flush'] = 1 
				@hand_score = 200		 
				end	
			end 	
		end # ends loop for object 
		expect(info['Royal']).to eq 1
		expect(@hand_score).to eq 600 
		expect(info['sflush']).to_not eq 1
		expect(info['flush']).to_not eq 1 
	end 

	it "should result as full house and not 3kind or pair " do 
		@hand_score = 0
 		info = { '3' => 5, 'H' => 2, 'A' =>3, 'J' =>2, 'Royal' => 0, 'sflush' => 0, 'flush' => 0, 'house' => 0, '3kind' =>0, 'pair' => 0}
		# if we have both a 3 of a kind and a pair we have a full house
		 info.each do |key,val|
		 	if info[key] ==2 || info[key] == 3
				# if 3 of a kind, we dont want to test for pair so we look for 3kind first 
				if info[key] == 3 && key != 'H' && key != 'S' && key != 'D' && key != 'C' && key != 'max' && key != 'pair'
					info['3kind'] =1
					# see if 3kind is best hand, if so make max value 
					if @hand_score < 50
						@hand_score = 50
					end 
					# test for pair if not a 3 of a kind 
				elsif info[key] == 2 && key != 'H' && key != 'C' && key != 'max' && key != 'S' && key != 'D' && key != 'pair'
					info['pair'] +=1
					# see if pair is best hand, if so, set max to value 
					if @hand_score < 20* info['pair']
						@hand_score = 20*info['pair']
					end 
				end	 
			end 
		end 
		if info['3kind'] == 1 && info['pair'] == 1
		   info['house'] = 1
		   @hand_score = 300
		end
		expect(info['house']).to eq 1 
		expect(@hand_score).to eq 300
	end 

	it "should push High Card to actual array" do 
	 	@combo_name = [] 
	 	@hand_score = 9

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
    		@combo_name.push("A Royal flush")
    	end   
	 	expect(@combo_name[0]).to eq "High Card"
	end 

	it "should push Royal Flush to actual array" do 
	 	@combo_name = [] 
	 	@hand_score = 600

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
	 	expect(@combo_name[0]).to eq "A Royal Flush"
	end 	

	it "should keep the values of the original array saved after copy" do
	 	@searchinfo = ['a', 'b', 'c']
	 	@hand_information_player_1 = @searchinfo.dup
	 	@searchinfo = ['d']
	 	expect(@hand_information_player_1).to eq ['a', 'b', 'c']
	 	expect(@searchinfo).to eq ['d']
	end 

	it " should find the correct winner if both have a pair" do 
		
		# Case 1 Higher Pair  
		# Case 2 Same pair, look in single cards for winner 
		
		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [20,20] # A pair is a value of 20 
		@best_card_value_2 = [20,20]
		@combo_name_1 = ["A Pair", "A Pair"] 
		@hand_information_player_1 = [{'pairvals' => [5]},{'pairvals' => [5], 'vals' => [4,4,3]}]
		@hand_information_player_2 = [{'pairvals' => [3]},{'pairvals' => [5], 'vals' => [4,4,2]}]
		for i in 0..@best_card_value_1.length-1 do 
			if @best_card_value_1[i] == @best_card_value_2[i]
				if @combo_name_1[i] == "A Pair" # Modified @combo_name_1[i][0] to @best[i] for the example 
					if @hand_information_player_1[i]['pairvals'][0] > @hand_information_player_2[i]['pairvals'][0]
						@tie_1[i] = @hand_information_player_1[i]['pairvals'][0]
						@tie_2[i] = 0
					elsif @hand_information_player_1[i]['pairvals'][0] < @hand_information_player_2[i]['pairvals'][0]
						@tie_2[i] = @hand_information_player_1[i]['pairvals'][0]
						@tie_1[i] = 0
					elsif @hand_information_player_1[i]['pairvals'][0] == @hand_information_player_2[i]['pairvals'][0]
						for k in 1..4 do
							if @hand_information_player_1[i]['vals'].sort[-k] > @hand_information_player_2[i]['vals'].sort[-k]
								@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-k]
								@tie_2[i] = 0
								break 
							elsif @hand_information_player_1[i]['vals'].sort[-k] < @hand_information_player_2[i]['vals'].sort[-k]
								@tie_1[i] = 0
								@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-k]
								break
							end 
						end 
					end
				end 
			else 
				@tie_1[i] = 0
				@tie_2[i] = 0
			end

		end # Ends the loop for the different types of tied hands 
		expect(@tie_1[0]).to eq 5
		expect(@tie_1[1]).to eq 3 
	end 

	it "should find the correct winner if both players have two pair " do 

		# Case 1 2nd pair wins   
		# Case 2 Same pairs, look in single cards for winner (highest)
		
		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [40,40] # A pair is a value of 20 
		@best_card_value_2 = [40,40]
		@combo_name_1 = ["Two Pair", "Two Pair"] 
		@hand_information_player_1 = [{'pairvals' => [7,6]},{'pairvals' => [7,6], 'vals' => [7,6,3]}]
		@hand_information_player_2 = [{'pairvals' => [7,5]},{'pairvals' => [7,6], 'vals' => [7,6,2]}]

		for i in 0..@best_card_value_1.length-1 do 

			if @best_card_value_1[i] == @best_card_value_2[i]

				if @combo_name_1[i] == "Two Pair" # Modified for test @best[i][0] in actual program  
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
							for k in 1..3 do
								if @hand_information_player_1[i]['vals'].sort[-k] > @hand_information_player_2[i]['vals'].sort[-k]
									@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-k]
									@tie_2[i] = 0
									break 
								elsif @hand_information_player_1[i]['vals'].sort[-k] < @hand_information_player_2[i]['vals'].sort[-k]
									@tie_1[i] = 0
									@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-k]
									break
								end 
							end
						end
					end
				end  
			end 
		end
		expect(@tie_1[0]).to eq 6
		expect(@tie_1[1]).to eq 3 
	end 

	it "should find the correct winnner with high card " do 

		# Case 1 2nd pair wins   
		# Case 2 Same pairs, look in single cards for winner (highest)
		
		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [10,10] # A pair is a value of 20 
		@best_card_value_2 = [10,10]
		@combo_name_1 = ["High Card", "High Card"] 
		@hand_information_player_1 = [{'vals' => [10,5,3]},{ 'vals' => [10,7,6,4,3]}]
		@hand_information_player_2 = [{'vals' => [10,4,3]},{ 'vals' => [10,7,6,4,2]}]
	
	for i in 0..@best_card_value_1.length-1 do 

			if @best_card_value_1[i] == @best_card_value_2[i]

				if @combo_name_1[i] == "High Card" # again modified for test 
					for k in 1..5 do
						if @hand_information_player_1[i]['vals'].sort[-k] > @hand_information_player_2[i]['vals'].sort[-k]
							@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-k]
							@tie_2[i] = 0
							break 
						elsif @hand_information_player_1[i]['vals'].sort[-k] < @hand_information_player_2[i]['vals'].sort[-k]
							@tie_1[i] = 0
							@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-k]
							break
						end 
					end 
				end
			end
		end
		expect(@tie_1[0]).to eq 5
		expect(@tie_1[1]).to eq 3  
	end 

	it "Should result in the straight flush with the higher high card winning " do

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [500] # A pair is a value of 20 
		@best_card_value_2 = [500]
		@combo_name_1 = ["A Straight Flush"]
		@hand_information_player_1 = [{'vals' => [5,6,7,8,9,10], 'D' => 5}]
		@hand_information_player_2 = [{'vals' => [6,7,8,9,10,11],'D' => 5}]
		for i in 0..@best_card_value_1.length-1 do
			if @hand_information_player_1[i]['H'] == 5 || @hand_information_player_1[i]['S'] == 5 || @hand_information_player_1[i]['D'] == 5 || @hand_information_player_1[i]['C'] == 5  
				if @combo_name_1[i] == "A Straight Flush" # This line has been modified for testing purposes
					if @hand_information_player_1[i]['vals'].sort[-1] > @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = @hand_information_player_1[i]['vals'].sort[-1]
						@tie_2[i] = 0 
					elsif @hand_information_player_1[i]['vals'].sort[-1] < @hand_information_player_2[i]['vals'].sort[-1]
						@tie_1[i] = 0
						@tie_2[i] = @hand_information_player_2[i]['vals'].sort[-1]
					end 
				end
			end
		end 
		expect(@tie_2[0]).to eq 11 
		expect(@tie_1[0]).to eq 0   
	end 

	it "Should result in the higher four of a kind winning " do

	class Array
	  def mode
	    sort_by {|i| grep(i).length }.last
	  end
	end

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [400] # A pair is a value of 20 
		@best_card_value_2 = [400]
		@combo_name_1 = ["Four of a Kind","Four of a Kind"] 
		@hand_information_player_1 = [{'vals' => [5,5,5,5,5,10]}]
		@hand_information_player_2 = [{'vals' => [4,4,4,4,4,11]}]
		for i in 0..@best_card_value_1.length-1 do 
			if @combo_name_1[i] == "Four of a Kind" # This line has been modified for testing purposes
				if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = @hand_information_player_1[i]['vals'].mode
					@tie_2[i] = 0 
				elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = 0
					@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				end 
			end
		end
		expect(@tie_2[0]).to eq 0 
		expect(@tie_1[0]).to eq 5   
	end 

	it "Should result in the higher 3 of a kind winning " do
		
	class Array
	  def mode
	    sort_by {|i| grep(i).length }.last
	  end
	end

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [50] # A pair is a value of 20 
		@best_card_value_2 = [50]

		@combo_name_1 = ["Three of a Kind"] 
		@hand_information_player_1 = [{'vals' => [5,5,5,5,3,10]}]
		@hand_information_player_2 = [{'vals' => [4,4,4,4,3,11]}]
		for i in 0..@best_card_value_1.length-1 do 
			if @combo_name_1[i] == "Three of a Kind" # This line has been modified for testing purposes
				if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = @hand_information_player_1[i]['vals'].mode
					@tie_2[i] = 0 
				elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = 0
					@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				end 
			end
		end
		expect(@tie_2[0]).to eq 0 
		expect(@tie_1[0]).to eq 5   
	end 

it "Should result in the higher full house winning" do
		
	class Array
	  def mode
	    sort_by {|i| grep(i).length }.last
	  end
	end

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [300] # A pair is a value of 20 
		@best_card_value_2 = [300]
		
		@combo_name_1 = ["Full House"] 
		@hand_information_player_1 = [{'vals' => [5,5,5,5,3,3]}]
		@hand_information_player_2 = [{'vals' => [4,4,4,4,2,2]}]
		for i in 0..@best_card_value_1.length-1 do 
			if @combo_name_1[i] == "Full House" # This line has been modified for testing purposes
				if @hand_information_player_1[i]['vals'].mode > @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = @hand_information_player_1[i]['vals'].mode
					@tie_2[i] = 0 
				elsif @hand_information_player_1[i]['vals'].mode < @hand_information_player_2[i]['vals'].mode
					@tie_1[i] = 0
					@tie_2[i] = @hand_information_player_2[i]['vals'].mode
				end 
			end
		end
		expect(@tie_2[0]).to eq 0 
		expect(@tie_1[0]).to eq 5   
	end 

it "Should result in the higher straight winning" do
		

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [100] # A pair is a value of 20 
		@best_card_value_2 = [100]
		
		@combo_name_1 = ["A Straight"] 
		@hand_information_player_1 = [{'vals' => [2,3,4,5,6,7], 'max' => 7}]
		@hand_information_player_2 = [{'vals' => [3,4,5,6,7,8], 'max' => 8}]
		for i in 0..@best_card_value_1.length-1 do 
			if @combo_name_1[i] == "A Straight" # This line has been modified for testing purposes
				if @hand_information_player_1[i]['max'] > @hand_information_player_2[i]['max']
					@tie_1[i] = @hand_information_player_1[i]['vals']['max']
					@tie_2[i] = 0 
				elsif @hand_information_player_1[i]['max'] < @hand_information_player_2[i]['max']
					@tie_1[i] = 0
					@tie_2[i] = @hand_information_player_2[i]['max']
				end 
			end
		end
		expect(@tie_2[0]).to eq 8 
		expect(@tie_1[0]).to eq 0   
	end 

it "Should result in the higher flush winning" do
		

		@tie_1 = Array.new
		@tie_2 = Array.new 

		@best_card_value_1 = [200] # A pair is a value of 20 
		@best_card_value_2 = [200]
		
		@combo_name_1 = ["A Flush"] 
		@hand_information_player_1 = [{'vals' => [2,3,4,5,6,7], 'max' => 7, 'D' => 5}]
		@hand_information_player_2 = [{'vals' => [3,4,5,6,7,8], 'max' => 8, 'D' => 5}]
		for i in 0..@best_card_value_1.length-1 do 
			if @combo_name_1[i] == "A Flush" # This line has been modified for testing purposes
				if @hand_information_player_1[i]['max'] > @hand_information_player_2[i]['max']
					@tie_1[i] = @hand_information_player_1[i]['vals']['max']
					@tie_2[i] = 0 
				elsif @hand_information_player_1[i]['max'] < @hand_information_player_2[i]['max']
					@tie_1[i] = 0
					@tie_2[i] = @hand_information_player_2[i]['max']
				end 
			end
		end
		expect(@tie_2[0]).to eq 8 
		expect(@tie_1[0]).to eq 0   
	end 

it "should keep a numerical value and change the face card to a face card " do
	
	@best_card_value_1 = [5, 13]
	@high_card_winner_1 = []

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
	end
	expect(@high_card_winner_1[0]).to eq 5
	expect(@high_card_winner_1[1]).to eq 'K'
	end   	
end # end spec (controller)
