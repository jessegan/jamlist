class Playlist < ApplicationRecord

    ### ASSOCIATIONS

    belongs_to :group
    has_many :playlist_tracks, dependent: :destroy
    has_many :tracks, through: :playlist_tracks

    ### VALIDATIONS

    validates :name, {presence: true, uniqueness: {scope: :group, message: "should be unique per group"}}
    validates :description, length: {maximum: 500}

    ### INSTANCE METHODS

    # Adds track to playlist
    # @params track [Track] track object to be added
    def add_track(track)
        unless self.tracks.include?(track)
            self.tracks << track
        end
        
        track
    end

    # Remove tracks from playlist
    # @params tracks [Array<Track>] array of tracks to be removed
    def remove_tracks(tracks)

        tracks.each do |track|
            self.tracks.destroy(track) # remove association
        end

        tracks
    end

    # Returns an RSpotify::Playlist object of the playlist
    # @return [RSpotify::Playlist] the resulting Playlsit object
    def rspotify_playlist
        if !self.spotify_id.nil?
            @rspotify_playlist ||= RSpotify::Playlist.find_by_id(self.spotify_id)
        end
    end

    # Creates a playlist on Spotify under the owner's account
    # @return [Playlist] the Playlist calling the method, or nil if playlist has already been created
    def add_to_spotify
        if self.spotify_id.nil?
            playlist = self.group.owner.rspotify_user.create_playlist!(self.name)
            self.spotify_id = playlist.id
            self.save
            self
        else
            nil
        end
    end

    # Syncs all tracks with its Spotify playlist
    # @return [Playlist] the Playlist calling the method
    def sync_tracks_to_spotify
        if self.spotify_id.nil?
            self.add_to_spotify
        end

        owner = self.group.owner.rspotify_user

        tracks = self.tracks.map(&:rspotify_track)

        self.rspotify_playlist.replace_tracks!(tracks)

        self
    end

    # Syncs playlist name with its spotify playlist
    # @return [Playlist] the Playlist calling the method
    def sync_details_to_spotify
        owner = self.group.owner.rspotify_user
        
        self.rspotify_playlist.change_details!(name: self.name)

        self
    end

end
