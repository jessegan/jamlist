class Playlist < ApplicationRecord

    ### ASSOCIATIONS

    belongs_to :group

    ### VALIDATIONS

    validates :name, {presence: true, uniqueness: {scope: :group, message: "should be unique per group"}}
    validates :description, length: {maximum: 500}
    validates :spotify_id, {presence: true, uniqueness: true}

end
