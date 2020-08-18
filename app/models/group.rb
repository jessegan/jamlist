class Group < ApplicationRecord
    ### ASSOCIATIONS

    has_many :members, dependent: :destroy
    has_many :users, through: :members
    belongs_to :owner, class_name: "User"

    ### VALIDATIONS

    validates :name, presence: true
    attribute :public, :boolean, default: true

    ### SCOPES


    ### INSTANCE METHODS

end
