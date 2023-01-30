Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "tournaments#index"

  get '/poker/assets/leaderboard/:event_id', to: 'tournaments#show', as: 'tournament'

end
