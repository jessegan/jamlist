class TrackArtist < ApplicationRecord

  ### ASSOCIATIONS

  belongs_to :track
  belongs_to :artist

  ### VALIDATIONS


end
