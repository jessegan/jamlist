class Group < ApplicationRecord
    ### ASSOCIATIONS

    ### VALIDATIONS

    validates :name, presence: true
    attribute :public, :boolean, default: true

end
