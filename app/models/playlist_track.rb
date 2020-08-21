class PlaylistTrack < ApplicationRecord

  ### ASSOCIATIONS

  belongs_to :playlist
  belongs_to :track
  
end
