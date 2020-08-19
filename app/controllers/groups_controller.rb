class GroupsController < ApplicationController

    ### CALLBACKS

    before_action :require_signed_in
    before_action :set_group, only: [:show]

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

    private
    
    def set_group
        @group = Group.find(params[:id])
    end

end
