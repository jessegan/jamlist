class Group < ApplicationRecord
    ### ASSOCIATIONS

    has_many :members, dependent: :destroy
    has_many :users, through: :members
    belongs_to :owner, class_name: "User"

    ### VALIDATIONS

    validates :name, presence: true
    attribute :public, :boolean, default: true

    ### CALLBACKS

    after_save :add_owner_to_members

    ### SCOPES

    scope :public_only, -> {where(public: true)}
    scope :private_only, -> {where(public: false)}

    ### INSTANCE METHODS

    def add_member(user)
        self.users << user
    end

    private

    def add_owner_to_members
        if self.owner && !self.members.exists?(user: self.owner)
            self.members.create(user: self.owner, admin: true)
        end
    end

end
