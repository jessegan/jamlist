class User < ApplicationRecord
    ### ASSOCIATIONS

    has_one :credential, class_name: "SpotifyCredential", foreign_key: "user_id", dependent: :destroy

    ### VALIDATIONS

    has_secure_password

    validates :email, {presence: true, uniqueness: true}
    validates :display_name, {presence: true}
    validates :credential, presence: true
    validates :spotify_id, {presence: true, uniqueness: true}

    ### CALLBACKS

    before_validation :lowercase_email_before_validation


    ### INSTANCE METHODS
    
    def to_rspotify_hash
        {id: self.spotify_id, credentials: self.credential.to_rspotify_hash}
    end

    ### PRIVATE METHODS
    
    private

    def lowercase_email_before_validation
        self.email.downcase!
    end

end
