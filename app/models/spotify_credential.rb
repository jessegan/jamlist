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
    
    ### INSTANCE METHODS

    def to_rspotify_hash
        {"token" => self.token, "refresh_token" => self.refresh_token, "expires_at" => self.expires_at, "expires" => self.expires}
    end
end
