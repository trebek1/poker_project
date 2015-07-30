require "rails_helper"

 describe "Routes" do
    it "routes to simulations" do
      expect(:get => "/simulations").to route_to(
        :controller => "simulations",
        :action => "index"
      )
    end
    it "root route" do
      expect(:get => "/").to route_to(
        :controller => "simulations",
        :action => "index"
      )
    end
end 