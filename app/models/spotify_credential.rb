class SpotifyCredential < ApplicationRecord
    ### ASSOCATIONS
    belongs_to :user

    ### VALIDATIONS
    validates :user, presence: true
    validates :token, presence: true
    validates :refresh_token, presence: true
    validates :expires_at, presence: true
    validates :expires, presence: true

    ### CALLBACKS
    
end
