class StaticController < ApplicationController

    ### CALLBACKS
    
    before_action :redirect_if_signed_in, only: [:home]

    ## Home
    # Root page. 
    # Holds links for user to login or connect to spotify.
    def home
    end

end
