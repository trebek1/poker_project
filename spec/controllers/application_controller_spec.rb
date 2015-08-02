require "rails_helper"

RSpec.describe SimulationsController do

    it "adds a new key if one does not exist" do
    	card = 2
    	@info = {}
	    if @info[card] == nil
				@info[card] = 1
		else
				@info[card]+=1
		end   
    	expect(@info[2]).to equal 1 
    end 
    it "increments value by one if card exists" do

		card = 2
		@info = {2 => 1}
	    if @info[card] == nil
				@info[card] = 1
		else
				@info[card]+=1
		end   

    	expect(@info[2]).to equal 2
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
	    @info = {}

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
				@info['max'] = max
			end
		end # end for loop
	 	expect(max).to equal 7
	 	expect(@info['max']).to equal 7
 	end # end case 

 	it " should test positive for a pair (and ignore the suits) and set value equal to 20" do 
	 	@top = 0
 		@info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>2, 'pair'=> 0}
 		@info.each do |key,val|
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
		end 
		expect(@top).to eql 20
		expect(@info['pair']).to eql 1
	end 

	it " should test positive for 2 pair (and ignore the suits) and set value equal to 40" do 
	 	@top = 0
 		@info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>2, '7' =>2, 'pair'=> 0}
 		@info.each do |key,val|
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
		end 
		expect(@top).to eql 40
		expect(@info['pair']).to eql 2
	end 

	it " should test positive for a 3 of a kind and set value equal to 50" do 
	 	@top = 0
 		@info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>3, 'pair'=> 0, '3kind' => 0}
 		@info.each do |key,val|
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
		end 
		expect(@top).to eql 50
		expect(@info['3kind']).to eql 1
	end 

	it "should test four of a kind (4kind =1 ) and set value to 400 also make sure pair is not being triggered twice" do 
		
		@top = 0
 		@info = {'H' => 2, 'S' => 2, 'D' => 2, 'C' => 2, '4' =>4, 'pair'=> 0, '3kind' => 0, '4kind' => 0}
		@info.each do |key,val|
			if @info[key] ==4 && key!= 'H' && key!= 'S' && key!='D' && key!='C' && key!= 'max' 
						@info['4kind'] = 1
						@top = 400 
			end
		end
			expect(@top).to eql 400
			expect(@info['4kind']).to eq 1
			expect(@info['pair']).not_to eq 2 
	end 
	
	it "Should test that straight is triggered for a straight and assign a value of 100" do 
		@top = 0
 		@info = {'A' => 1, '2' => 1, '3' => 1, '4' => 1, '5' =>1, 'pair'=> 0, '3kind' => 0, '4kind' => 0, 'straight' => 0}
		
 			if    @info['A'] == 1 && @info['2'] == 1 && @info['3'] == 1 && @info['4'] == 1 && @info['5'] ==1
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
		
		expect(@top).to eq 100
		expect(@info['straight']).to eq 1   
	end 

	it "should test for flush but not royal or straight" do 
		@top = 0
			@info = { 'D' => 5, '2' =>1, '4' =>3, 'pair'=> 0, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			@info.each do |key,val|
		
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
		end # ends loop for object 
		expect(@info['flush']).to eq 1
		expect(@top).to eq 200 
		expect(@info['Royal']).to_not eq 1
		expect(@info['sflush']).to_not eq 1 
	end 

	it "should test for straigh flush but not royal or regular flush" do 
		@top = 0
			@info = { 'D' => 5, '2' =>1, '3' =>1, '4'=> 1, '5' => 1, '6' => 1, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			@info.each do |key,val|
		
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
		end # ends loop for object 
		expect(@info['sflush']).to eq 1
		expect(@top).to eq 500 
		expect(@info['Royal']).to_not eq 1
		expect(@info['flush']).to_not eq 1 
	end 

	it "should test for royal flush but not straight or regular flush" do 
		@top = 0
		@info = { 'D' => 5, 'T' =>1, 'J' =>1, 'Q'=> 1, 'K' => 1, 'A' => 1, 'Royal' => 0, 'sflush' => 0, 'flush' => 0}
			
			@info.each do |key,val|
		
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
		end # ends loop for object 
		expect(@info['Royal']).to eq 1
		expect(@top).to eq 600 
		expect(@info['sflush']).to_not eq 1
		expect(@info['flush']).to_not eq 1 
	end 

	it "should result as full house and not 3kind or pair " do 
		@top = 0
 		@info = { '3' => 5, 'H' => 2, 'A' =>3, 'J' =>2, 'Royal' => 0, 'sflush' => 0, 'flush' => 0, 'house' => 0, '3kind' =>0, 'pair' => 0}
		# if we have both a 3 of a kind and a pair we have a full house
		 @info.each do |key,val|
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
		end 
		if @info['3kind'] == 1 && @info['pair'] == 1
		   @info['house'] = 1
		   @top = 300
		end
		expect(@info['house']).to eq 1 
		expect(@top).to eq 300
	end 

	it "should push High Card to actual array" do 
	 	@actual = [] 
	 	@top = 9

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
    		@actual.push("A Royal flush")
    	end   
	 	expect(@actual[0]).to eq "High Card"
	end 

	it "should push Royal Flush to actual array" do 
	 	@actual = [] 
	 	@top = 600

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
	 	expect(@actual[0]).to eq "A Royal Flush"
	end 	

	it "should keep the values of the original array saved after copy" do
	 	@searchinfo = ['a', 'b', 'c']
	 	@player1hands = @searchinfo.dup
	 	@searchinfo = ['d']
	 	expect(@player1hands).to eq ['a', 'b', 'c']
	 	expect(@searchinfo).to eq ['d']
	end 

	it " should find the correct winner if both have a par" do 
		
		# Case 1 Higher Pair  
		# Case 2 Same pair, look in single cards for winner 
		
		@tie1 = Array.new
		@tie2 = Array.new 

		@top1 = [20,20] # A pair is a value of 20 
		@top2 = [20,20]
		@best1 = ["A Pair", "A Pair"] 
		@player1hands = [{'pairvals' => [5]},{'pairvals' => [5], 'vals' => [4,4,3]}]
		@player2hands = [{'pairvals' => [3]},{'pairvals' => [5], 'vals' => [4,4,2]}]
		for i in 0..@top1.length-1 do 
			if @top1[i] == @top2[i]
				if @best1[i] == "A Pair" # Modified @best1[i][0] to @best[i] for the example 
					if @player1hands[i]['pairvals'][0] > @player2hands[i]['pairvals'][0]
						@tie1[i] = @player1hands[i]['pairvals'][0]
						@tie2[i] = 0
					elsif @player1hands[i]['pairvals'][0] < @player2hands[i]['pairvals'][0]
						@tie2[i] = @player1hands[i]['pairvals'][0]
						@tie1[i] = 0
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
				@tie1[i] = 0
				@tie2[i] = 0
			end

		end # Ends the loop for the different types of tied hands 
		expect(@tie1[0]).to eq 5
		expect(@tie1[1]).to eq 3 
	end 

end # end spec (controller)
