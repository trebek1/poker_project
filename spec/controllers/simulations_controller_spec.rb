require "rails_helper"

RSpec.describe SimulationsController do

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

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
 	
end 