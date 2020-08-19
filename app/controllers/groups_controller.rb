class GroupsController < ApplicationController

    ### HELPERS

    helper_method :current_group, :member_of

    ### CALLBACKS

    before_action :require_signed_in
    before_action :require_member_of_group_if_private, only: [:show]

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

    ## new
    # New group route
    # Form to create new group
    def new
        @group = current_user.new_group()
    end

    ## create
    # create group route
    # Handles group creation
    def create
        @group = current_user.new_group(group_params)
        if @group.save
            redirect_to @group
        else
            render :new
        end
    end

    ## join
    # Join Group route
    # Add current to group and then redirect to group show page
    def join
        if !member_of(current_group)
            current_group.add_member(current_user)
            
            redirect_to current_group
        end
    end

    ### HELPERS

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

    def require_member_of_group_if_private
        if !current_group.public
            require_member_of_group
        end
    end

    private 

    def group_params
        params.require(:group).permit(:name,:description,:public)
    end

end

