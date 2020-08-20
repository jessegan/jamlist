class PlaylistsController < ApplicationController

    ### HELPERS

    helper_method :current_group, :current_playlist

    ### CALLBACKS

    before_action :require_playlist_in_group, only: [:show]
    
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


    private 

    def current_group
        @group ||= Group.find(params[:group_id])
    end

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
