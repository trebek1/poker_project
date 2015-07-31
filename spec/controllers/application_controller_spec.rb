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

    it "finds the max value and assigns max for the hand to that value" do
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
 	it "finds the max value and assigns max for the hand to that value" do
	    examplehand = '7C3S3C3H3S'
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
 	expect(max).to equal 7
 	end # end case  	
end # end spec (controller)
