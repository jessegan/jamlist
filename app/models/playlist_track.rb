class PlaylistTrack < ApplicationRecord

  ### ASSOCIATIONS

  belongs_to :playlist
  belongs_to :track

  ### VALIDATIONS

  validates :track, uniqueness: {scope: :playlist}

end
