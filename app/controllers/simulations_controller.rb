class SimulationsController < ApplicationController
  def index
  	@data = File.read("poker.txt").gsub(/\s+/, "").scan(/.{10}/) # Data from file removing dashes
  	# and making into 10 piece increments so that each one is a "hand" for either player 1 or 2 

  	@hands1 = Array.new # player 1 and player 2 hands arrays ( just the cards from the file)
  	@hands2 = Array.new
  	@player1hands = Hash.new #player hands with calculated information about combinations
    @player2hands = Hash.new
    @info = Hash.new # info about the given hand in the hand_results function
    @eachinfo = Hash.new # object with all info for all hands (for given player) in hand results function   
    
    #Store best hand numerical value 
    @top1 = Array.new 
    @top2 = Array.new

    #best hand in card value 
    @best1 = Array.new
    @best2 = Array.new    

    #number of wins for player 1 and player 2 
    @wins1 = 0
    @wins2 = 0

    @highcardwinner1 = Array.new 
    @highcardwinner2 = Array.new

    data.each_with_index do |data,index|
  		if index % 2 === 0 
  			@hands1.push(data)
  		else 
  			@hands2.push(data) 
  		end 
  	end # Ends loop to push players their hands 
  end# ends lop for index definition
end# ends class definition
