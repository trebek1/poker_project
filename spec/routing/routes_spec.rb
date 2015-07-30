require "rails_helper"

 describe "Routes", :type => :routing do
    it "routes get index" do
      expect(:get => "simulations").to route_to(
        :controller => "simulations",
        :action => "index"
      )
    end
end 