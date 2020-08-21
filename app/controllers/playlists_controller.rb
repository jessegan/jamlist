class PlaylistsController < ApplicationController

    ### HELPERS

    helper_method :current_playlist

    ### CALLBACKS

    before_action :require_member_of_group_if_private
    before_action :require_member_of_group, only: [:new, :create, :destroy]
    before_action :require_admin_of_group, only: [:new, :create, :destroy]
    before_action :require_playlist_in_group, only: [:show, :destroy]
    
    ### ACTIONS

    ## show
    # show playlist route
    # renders a playlist's page
    def show
    end

    ##new
    # new playlist route
    # renders form to create new playlist
    def new
        @playlist = current_group.playlists.build()
    end

    ##create
    # create playlist route
    # handles creation of new playist
    def create
        @playlist = current_group.playlists.build(playlist_params)
        if @playlist.save
            @playlist.add_to_spotify

            redirect_to group_playlist_path(current_group,@playlist)
        else  
            # TODO: add flash error
            render :new
        end
    end

    ## edit
    # edit playlist route
    # render edit playlist form
    def edit
    end

    ## update
    # update playlist route
    # handles the updating of the current playlist
    def update
        if current_playlist && current_playlist.update(playlist_params)
            redirect_to [current_group,current_playlist]
        else
            # TODO: add flash error
            render :edit
        end
    end

    ## destroy
    # destroy playlist route
    # handles deleting a playlist from a group
    def destroy
        current_playlist.destroy

        redirect_to current_group
    end

    ### METHODS
    
    # Returns the current group of the page
    # @return [Group] the current group of the page
    def current_group
        @group ||= Group.find(params[:group_id])      
    end

    private 

    def current_playlist
        @playlist ||= Playlist.find(params[:id])
    end

    def require_playlist_in_group
        if !current_group.playlists.include?(current_playlist)
            # TODO: add flash error
            redirect_to current_group
        end
    end

    def playlist_params
        params.require(:playlist).permit(:name,:description)
    end

end
