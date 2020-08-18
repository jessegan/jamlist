class Group < ApplicationRecord
    ### ASSOCIATIONS

    has_many :members, dependent: :destroy
    has_many :users, through: :members

    ### VALIDATIONS

    validates :name, presence: true
    attribute :public, :boolean, default: true

end
