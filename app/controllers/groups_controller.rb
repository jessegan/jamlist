class GroupsController < ApplicationController

    ### HELPERS

    helper_method :current_group_members

    ### CALLBACKS

    before_action :require_signed_in
    before_action :require_member_of_group_if_private, only: [:show]
    before_action :require_member_of_group, only: [:members]
    before_action :require_admin_of_group, only: [:edit,:edit_members]

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
        binding.pry
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

    ## members
    # Members route
    # render page that shows the group's members
    def members
    end

    ## edit_members
    # Edit members route
    # render form to remove group members
    def edit_members
    end

    ## update_members
    # Update members route
    # Handle updating the members of the group
    def update_members
        if current_group && current_group.update(group_params)
            
            redirect_to members_group_path(current_group)
        else
            render :edit_members
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

    ## leave
    # Leave group route
    # Removes the current user from a group
    def leave
        current_user.leave_group(current_group)

        redirect_to home_path
    end

    ### HELPERS

    # Returns the current group of the page
    # @return [Group] the current group of the page
    def current_group
        @group ||= Group.find(params[:id])      
    end

    # Returns list of current group's methods
    # @return [Array<Member>] list of Members in the group
    def current_group_members
        @members ||= current_group.members
    end

    private 

    def group_params
        params.require(:group).permit(:name,:description,:public,member_ids:[])
    end

end

