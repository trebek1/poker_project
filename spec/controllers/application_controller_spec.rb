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
 end 	

