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
  resources :groups do
    member do
      post 'join', to: 'groups#join'
      post 'leave', to: 'groups#leave'

      # Managing members and admins
      get 'members', to: 'groups#members'
      get 'members/edit', to: 'groups#edit_members', as: 'edit_members'
      post 'members', to: 'groups#update_members'

      get 'admins', to: 'groups#edit_admins'
      post 'admins', to: 'groups#update_admins'

    end

    ## PLAYLISTS
    resources :playlists, path: "p", except: [:index] do
      member do
        post 'follow', to: 'playlists#follow'
        get 'tracks', to: 'playlists#tracks', as: "tracks"
        post 'tracks/:track_id', to: 'playlists#add_track', as: "add_track"
        get 'tracks/edit', to: 'playlists#edit_tracks', as: "edit_tracks"
        patch 'tracks', to: 'playlists#remove_tracks'
        post 'tracks', to: 'playlists#sync'
      end
    end
    
  end

end
