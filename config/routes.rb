Rails.application.routes.draw do

  ### ROOT
  root "static#home"

  ### SPOTIFY AUTH
  get "/auth/spotify/callback", to: "users#spotify"
  post "/signup", to: "users#create"

  ### LOGIN & LOGOUT
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  post '/logout', to: 'sessions#logout'

  ### GROUPS
  get '/home', to: 'groups#home', as: 'home'
  resources :groups

end
