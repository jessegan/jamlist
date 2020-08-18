class Group < ApplicationRecord
    ### ASSOCIATIONS

    ### VALIDATIONS

    validates :name, presence: true
    validates :public, presence: true
    attribute :public, :boolean, default: true

end
