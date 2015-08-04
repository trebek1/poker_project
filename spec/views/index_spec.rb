require "rails_helper"

RSpec.describe 'views/simulations/index.html.erb' do

	it "expects wins in increment given a win (player 1)" do
		@best_card_value_1 = [10]
		@best_card_value_2 = [5]
		@wins_1 = 0
		if @best_card_value_1[0] > @best_card_value_2[0]
			@wins_1+=1 
		end 
		expect(@wins_1).to eql 1
	end 
end 	