module PlaylistsHelper

    def display_rspotify_artist_names(track)
        track.artists.map {|a| a.name}.join(", ")
    end

end
