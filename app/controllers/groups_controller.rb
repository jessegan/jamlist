class GroupsController < ApplicationController

    before_action :require_signed_in

    ## home
    # Home page route
    # Shows User's owned and joined groups
    def home
    end

    ## index
    # Browse groups route
    # List all public groups -> allow users to join
    def index
        @groups = Group.public_only
    end


end
