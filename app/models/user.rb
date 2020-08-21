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

 
    ### INSTANCE METHODS

    def owned_groups_public_only
        self.owned_groups.public_only
    end

    def new_group(attributes=nil)
        self.owned_groups.build(attributes)
    end

    def groups_joined_not_owned
        self.groups.where.not(owner: self)
    end

    def is_member?(group)
        self.groups.include?(group)
    end

    def is_owner?(group)
        self.owned_groups.include?(group)
    end

    def is_admin?(group)
        group.admins.include?(self)
    end

    # Remove User from members of given group
    # @param group [Group] the given group to leave
    def leave_group(group)
        if is_member?(group)
            self.groups.destroy(group)
        end
    end
    
    def to_rspotify_hash
        {"id" => self.spotify_id, "credentials" => self.credential.to_rspotify_hash}
    end

    ## rspotify_user
    # creates and returns a RSpotify user
    def rspotify_user
        RSpotify::User.new(self.to_rspotify_hash)
    end

    ### PRIVATE METHODS
    
    private

    def lowercase_email_before_validation
        self.email.downcase!
    end

end
