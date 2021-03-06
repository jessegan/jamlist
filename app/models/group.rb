class Group < ApplicationRecord
    ### ASSOCIATIONS

    has_many :members, dependent: :destroy
    has_many :users, through: :members
    belongs_to :owner, class_name: "User"
    has_many :playlists, dependent: :destroy

    ### VALIDATIONS

    validates :name, presence: true
    attribute :public, :boolean, default: true
    validates :description, length: {maximum: 500}

    ### CALLBACKS

    after_save :add_owner_to_members

    ### SCOPES

    default_scope { order(name: :asc)}
    scope :public_only, -> {where(public: true)}
    scope :private_only, -> {where(public: false)}

    ### INSTANCE METHODS

    # Returns the number of members in the group
    # @return [Integer] the count of members in the group
    def members_count
        self.members.count
    end

    def add_member(user)
        self.users << user
    end

    def admin_users
        self.users.merge(self.admins)
    end

    def admins
        self.members.where(admin:true)
    end

    def update_admins(admins)
        self.members.each do |member|
            if member.admin && !admins.include?(member)
                member.update(admin: false)
            elsif !member.admin && admins.include?(member)
                member.update(admin: true)
            end
        end

        self.admins
    end

    private

    def add_owner_to_members
        if self.owner && !self.members.exists?(user: self.owner)
            self.members.create(user: self.owner, admin: true)
        end
    end

end
