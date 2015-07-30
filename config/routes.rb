Rails.application.routes.draw do

  root to: 'simulations#index'
  
  get '/simulations', to: 'simulations#index', as: "simulations"

end
