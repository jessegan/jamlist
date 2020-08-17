Rails.application.routes.draw do

  root "static#home"

  get "/auth/spotify/callback", to: "users#spotify"
  post "/signup", to: "users#create"
end
