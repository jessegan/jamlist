class User < ApplicationRecord
    ### ASSOCIATIONS

    has_one :credential, class_name: "SpotifyCredential", foreign_key: "user_id", dependent: :destroy
    accepts_nested_attributes_for :credential

    has_many :members, dependent: :destroy
    has_many :groups, through: :members
    has_many :owned_groups, class_name: "Group", foreign_key: "owner_id"
 
    ### VALIDATIONS

    has_secure_password

    validates :email, {presence: true, uniqueness: true}
    validates :display_name, {presence: true}
    validates :spotify_id, {presence: true, uniqueness: true}

    ### CALLBACKS

    before_validation :lowercase_email_before_validation

    ### SCOPES

    def groups_joined_not_owned
        self.groups.where.not(owner: self)
    end

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
