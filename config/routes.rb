Rails.application.routes.draw do

  ### ROOT
  root "static#home"

  ### SPOTIFY AUTH
  get "/auth/spotify/callback", to: "users#spotify"
  post "/signup", to: "users#create"

  ### LOGIN & LOGOUT
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  post '/logout', to: 'sessions#destroy'

  ### USERS
  resources :users, only: [:show,:edit,:update,:destroy]

  ### GROUPS
  get '/home', to: 'groups#home', as: 'home'
  resources :groups, params: "group_id" do
    member do
      post 'join', to: 'groups#join'
    end

    resources :playlists, path: "p", except: [:index]
    
  end

end
