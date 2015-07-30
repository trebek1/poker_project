class SimulationsController < ApplicationController
  def index
  	@data = File.read("poker.txt").gsub(/\s+/, "").scan(/.{10}/)

  end
end
