class PlaylistsController < ApplicationController

    ### HELPERS

    helper_method :current_group

    ### CALLBACKS

    
    ### ACTIONS

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

    def playlist_params
        params.require(:playlist).permit(:name,:description)
    end

end
