class ApplicationController < ActionController::Base

    helper_method :current_user, :user_signed_in?

    ## require_signed_in
    # Redirect to login page if user accessing a page they need to be signed in on
    def require_signed_in
        if !user_signed_in?
            #TODO: Add flash alert
            redirect_to login_path
        end
    end

    ## redirect_if_signed_in
    # Redirect to home page if User is already signed in
    def redirect_if_signed_in
        if user_signed_in?
            redirect_to home_path
        end
    end

    ## user_signed_in?
    # Returns true or false if user is signed in
    def user_signed_in?
        !!session[:user_id]
    end

    ## current_user
    # Return current user or find and store current user
    def current_user
        @user ||= User.find(session[:user_id])
    end

    ## current_spotify_user
    # Return current rspotify user or create new rspotify user based on current user
    def current_spotify_user
        @spotify_user ||= RSpotify::User.new(current_user.to_rspotify_hash)
    end

    ## logout
    # delete's the user_id from session
    def logout
        session.delete :user_id
    end

end
