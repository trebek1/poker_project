require "rails_helper"

RSpec.describe 'views/simulations/index.html.erb' do

	it "expects wins in increment given a win (player 1)" do
		@top1 = [10]
		@top2 = [5]
		@wins1 = 0
		if @top1[0] > @top2[0]
			@wins1+=1 
		end 
		expect(@wins1).to eql 1
	end 
end 	