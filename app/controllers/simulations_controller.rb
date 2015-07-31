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

    # Stores the high card name instead of the number for numbers > 9 
    @highcardwinner1 = Array.new 
    @highcardwinner2 = Array.new

    # Splits the hands between player 1 and 2 
    @data.each_with_index do |data,index|
  		if index % 2 === 0 
  			@hands1.push(data)
  		else 
  			@hands2.push(data) 
  		end 
  	end # Ends loop to push players their hands 
   
   # Evaluate player 1
    @hands1.each_with_index do |hand,index|
      hand_results(hand,index,1)      
    end 
    # Evaluate player 2 
    @hands2.each_with_index do |hand,index|
      hand_results(hand,index,2)  
    end 
    
    # find high card winner card from numerical representation
    for i in 0..@top1.length-1 do 
      if @top1[i] <= 10
        @highcardwinner1[i] = @top1[i]
      elsif @top1[i] == 11
        @highcardwinner1[i] = 'J'
      elsif @top1[i] == 12
        @highcardwinner1[i] = 'Q'
      elsif @top1[i] == 13
        @highcardwinner1[i] = 'K'
      elsif @top1[i] == 14
        @highcardwinner1[i] = "A"
      end 
      if @top2[i]<=10
        @highcardwinner2[i] = @top2[i]
      elsif @top2[i] == 11
        @highcardwinner2[i] = 'J'
      elsif @top2[i] == 12
        @highcardwinner2[i] = 'Q'
      elsif @top2[i] == 13
        @highcardwinner2[i] = 'K'
      elsif @top2[i] == 14
        @highcardwinner2[i] = "A"
      end 
    end 
  end 
end
