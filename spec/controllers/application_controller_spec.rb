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

end # end spec (controller)
