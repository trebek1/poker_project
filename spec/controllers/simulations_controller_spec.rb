require "rails_helper"

RSpec.describe SimulationsController do

    it "loads 2000 hands of poker of length 10" do
    	data = File.read("poker.txt").gsub(/\s+/, "").scan(/.{10}/)
    	expect(data.length).to equal 2000
    end 	
    
	it "Should create a new hash" do
    	@player1hands = Hash.new 
     	Hash.new.should == {}
     end 
	it "Should create a new array" do
    	@hands1 = Array.new 
     	Array.new.should == []
     end 
     it "should equal zero when set to zero" do 
     	@wins1 = 0
     	@wins1.should eql(0)
     end 
 	it "hands 1 and 2 should be half the size (1000) as the file" do 
     	data = File.read("poker.txt").gsub(/\s+/, "").scan(/.{10}/)
		@hands1 = Array.new
		@hands2 = Array.new
     	data.each_with_index do |data,index|
	  		if index % 2 === 0 
	  			@hands1.push(data)
	  		else 
	  			@hands2.push(data) 
	  		end
  		end  
  		expect(@hands2.length).to equal 1000 # if hands 2 = 1000 hands 1 must also equal 1000
  	end   	 
end 