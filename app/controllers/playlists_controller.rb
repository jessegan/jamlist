class PlaylistsController < ApplicationController

    ### HELPERS

    helper_method :current_playlist

    ### CALLBACKS

    before_action :require_signed_in
    before_action :require_member_of_group_if_private
    before_action :require_member_of_group, only: [:follow]
    before_action :require_admin_of_group, only: [:new, :create, :edit, :update, :destroy, :tracks,:add_track,:edit_tracks,:remove_tracks,:sync]
    before_action :require_playlist_in_group, except: [:new,:create]
    
    ### ACTIONS

    ## show
    # show playlist route
    # renders a playlist's page
    def show
        @tracks = current_playlist.tracks
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
            flash.alert = "Playlist already exists with that name."
            
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
            current_playlist.sync_details_to_spotify

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

    ## follow
    # follow playlist route
    # handles current user following the current playlist
    def follow
        current_user.follow_playlist(current_playlist)

        redirect_to [current_group,current_playlist]
    end

    ## tracks
    # tracks route
    # renders a search page for tracks to add to playlist
    def tracks
        if params[:q] && !params[:q].empty?
            @tracks = RSpotify::Track.search(params[:q], limit: 50, market: 'US')
        else
            @tracks = []
        end

        render "tracks"
    end

    ## add_track
    # add track route
    # handles adding a track to a playlist
    def add_track 
        # Check if Track object exists
        track = Track.find_by(spotify_id: params[:track_id])

        if track.nil?
            rspotify_track = RSpotify::Track.find(params[:track_id])

            track = Track.create_from_rspotify(rspotify_track)
        end

        current_playlist.add_track(track)

        redirect_to [current_group,current_playlist]
    end

    ## edit_tracks
    # edit tracks route
    # renders page for admins to remove songs
    def edit_tracks
        render "edit_tracks"
    end

    ## remove_tracks
    # remove tracks route
    # handles removing an multiple tracks from playlist
    def remove_tracks
        unless params[:tracks].nil?
            tracks = Track.find(params[:tracks])

            current_playlist.remove_tracks(tracks)
        end

        redirect_to [current_group,current_playlist]
    end

    ## sync
    # sync tracks route
    # handles syncing of tracks to spotify playlist
    def sync
        # TODO: Add flash alert
        current_playlist.sync_tracks_to_spotify

        redirect_to [current_group,current_playlist]
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
