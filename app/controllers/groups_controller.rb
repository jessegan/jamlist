class GroupsController < ApplicationController

    ### CALLBACKS

    before_action :require_signed_in

    ### ACTIONS

    ## home
    # Home page route
    # Shows User's owned and joined groups
    def home
    end

    ## index
    # Browse groups route
    # List all public groups -> links to group pages
    def index
        @groups = Group.public_only
    end

    ## show
    # Show group route
    # Show a group's page and show playlists
    def show
    end

    ### HELPERS
    helper_method :current_group, :member_of

    def current_group
        @group ||= Group.find(params[:id])      
    end

    def member_of(group)
        current_user.is_member?(group)
    end

    def require_member_of_group
        if !member_of(current_group)
            # TODO: Add flash alert
            redirect_back fallback_location: home_path
        end
    end

end

