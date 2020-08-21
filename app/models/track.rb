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
end
