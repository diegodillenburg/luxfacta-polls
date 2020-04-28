Rails.application.routes.draw do
  get '/poll/:id', to: 'polls#show'
  get '/poll/:id/stats', to: 'polls#stats'

  post '/poll', to: 'polls#create'
  post '/poll/:id/vote', to: 'polls#vote'
end
