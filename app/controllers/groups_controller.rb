class GroupsController < ApplicationController

    ### HELPERS



    ### CALLBACKS

    before_action :require_signed_in
    before_action :require_member_of_group_if_private, only: [:show]
    before_action :require_admin_of_group, only: [:edit]

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

    ## edit
    # Edit group route
    # Form to edit group details
    def edit
        current_group
    end

    ## update
    # update group route
    # Handle updating group info
    def update
        if current_group.update(group_params)
            redirect_to current_group
        else
            render :edit
        end
    end

    ## destroy
    # destory group route
    # Handle deleting a group
    def destroy
        current_group.destroy

        redirect_to home_path
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

    # Returns the current group of the page
    # @return [Group] the current group of the page
    def current_group
        @group ||= Group.find(params[:id])      
    end

    private 

    def group_params
        params.require(:group).permit(:name,:description,:public)
    end

end

