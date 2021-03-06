  require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_KEY'], ENV['SPOTIFY_SECRET'], scope: 'user-read-email playlist-read-collaborative playlist-modify-public playlist-read-private user-follow-read playlist-modify-private'
end