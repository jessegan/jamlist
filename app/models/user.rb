class User < ApplicationRecord
    ### VALIDATIONS
    has_secure_password

    validates :email, {presence: true, uniqueness: true}
    validates :display_name, {presence: true}


    ### CALLBACKS
    before_validation :lowercase_email_before_validation


    ### PRIVATE METHODS
    
    private

    def lowercase_email_before_validation
        self.email.downcase!
    end

end
