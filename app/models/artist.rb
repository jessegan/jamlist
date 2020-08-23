class Artist < ApplicationRecord

    ### ASSOCIATIONS

    has_many :track_artists, dependent: :destroy
    has_many :tracks, through: :track_artists

    ### VALIDATIONS

    validates :name, presence: true

end
