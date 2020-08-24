class Track < ApplicationRecord

    ### ASSOCIATIONS

    has_many :playlist_tracks, dependent: :destroy
    has_many :playlists, through: :playlist_tracks

    has_many :track_artists, dependent: :destroy
    has_many :artists, through: :track_artists
    accepts_nested_attributes_for :artists

    ### VALIDATIONS

    validates :name, presence: true
    validates :spotify_id, uniqueness: true

    ### CALLBACKS

    ### SCOPES

    ### CLASS METHODS

    # Creates and returns a new Track object from a RSpotify::Track
    # @param rspotify_track [RSpotify::Track] RSpotify Track to create a new Track from
    # @return [Track] initialized Track object
    def self.create_from_rspotify(rspotify_track)
        if Track.exists?(spotify_id: rspotify_track.id)
            track = Track.find_by(spotify_id: rspotify_track.id)
        else 
            track = Track.create(name: rspotify_track.name, spotify_id: rspotify_track.id, duration: rspotify_track.duration_ms, track_number: rspotify_track.track_number)

            
            rspotify_track.artists.each do |rspotify_artist|
                track.artists << Artist.find_or_create_by(spotify_id: rspotify_artist.id) do |artist|
                    artist.name = rspotify_artist.name
                end
            end
        end
        
        track
    end

    ### INSTANCE METHODS

    # Returns an RSpotify::Track object of the Track
    # @return [RSpotify::Track] the resulting Track object
    def rspotify_track
        if !self.spotify_id.nil?
            @rspotify_track ||= RSpotify::Track.find(self.spotify_id)
        end
    end
end
