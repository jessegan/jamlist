class Member < ApplicationRecord
    ### ASSOCIATIONS

    belongs_to :user
    belongs_to :group

    ### VALIDATIONS
    attribute :admin, :boolean, default: false

    ### SCOPES

    scope :admins, -> {where(admin:true)}

    ### INSTANCE METHODS

    def user_name
        self.user.display_name
    end

    def owner_of_group
        self.group.owner == self.user
    end

end
