class SimulationsController < ApplicationController
  def index
  	# Data from file removing dashes and making into 10 piece increments so that each one is a "hand" for either player 1 or 2 
    data = File.read("poker.txt").gsub(/\s+/, "").scan(/.{10}/) 
  	
    # info about the given hand in the hand_results function
    @info = Hash.new 

     # object with all info for all hands (for given player) in hand results function   
    @eachinfo = Hash.new 

    # player 1 and player 2 hands arrays (just the cards from the file)
    @hands_for_player_1 = Array.new 
  	@hands_for_player_2 = Array.new
  	
    #player hands with calculated information about combinations
    @hand_information_player_1 = Hash.new 
    @hand_information_player_2 = Hash.new
    
    #Store best hand numerical value 
    @best_card_value_1 = Array.new 
    @best_card_value_2 = Array.new

    #best hand in card in combo name 
    @combo_name_1 = Array.new
    @combo_name_2 = Array.new    

    #number of wins for player 1 and player 2 
    @wins_1 = 0
    @wins_2 = 0

    # Stores the high card name instead of the number for numbers > 10
    @high_card_winner_1 = Array.new 
    @high_card_winner_2 = Array.new

    # Splits the hands between player 1 and 2 
    data.each_with_index do |data,index|
  		if index % 2 == 0 
  			@hands_for_player_1.push(data)
  		else 
  			@hands_for_player_2.push(data) 
  		end 
  	end # Ends loop to push players their hands 
   
   # Evaluate player 1
    @hands_for_player_1.each_with_index do |hand,index|
      hand_results(hand,index,1)      
    end 
    # Evaluate player 2 
    @hands_for_player_2.each_with_index do |hand,index|
      hand_results(hand,index,2)  
    end 

   #find the best card to display when high card wins (A for 14, K for 13 etc)
   high_card_winner
   # run tie winner to get a result when there is a tie 
   tie_winner  
  end 
end
