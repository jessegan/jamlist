class Member < ApplicationRecord
    ### ASSOCIATIONS

    belongs_to :user
    belongs_to :group

    ### VALIDATIONS
    attribute :admin, :boolean, default: false
    attribute :creator, :boolean, default: false

end
