class Track < ApplicationRecord

    ### ASSOCIATIONS

    has_many :playlist_tracks, dependent: :destroy
    has_many :playlists, through: :playlist_tracks

    ### VALIDATIONS

    validates :name, presence: true
    validates :spotify_id, uniqueness: true

    ### CALLBACKS

    ### SCOPES

    ### INSTANCE METHODS

    # Returns an RSpotify::Track object of the Track
    # @return [RSpotify::Track] the resulting Track object
    def rspotify_track
        if !self.spotify_id.nil?
            @rspotify_track ||= RSpotify::Track.find(self.spotify_id)
        end
    end
end
