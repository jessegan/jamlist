class Playlist < ApplicationRecord

    ### ASSOCIATIONS

    belongs_to :group
    has_many :playlist_tracks, dependent: :destroy
    has_many :tracks, through: :playlist_tracks

    ### VALIDATIONS

    validates :name, {presence: true, uniqueness: {scope: :group, message: "should be unique per group"}}
    validates :description, length: {maximum: 500}

    ### INSTANCE METHODS

    ## add_to_spotify
    # adds playlist to Group owner's spotify account
    # options include public or private and collaborative options
    def add_to_spotify(options = {})
        if self.spotify_id.nil?
            playlist = self.group.owner.rspotify_user.create_playlist!(self.name)
            self.spotify_id = playlist.id
            self.save
        else
            false
        end
    end

    # Returns an RSpotify::Playlist object of the playlist
    # @return [RSpotify::Playlist] the resulting Playlsit object
    def rspotify_playlist
        if !self.spotify_id.nil?
            @rspotify_playlist ||= RSpotify::Playlist.find_by_id(self.spotify_id)
        end
    end

end
