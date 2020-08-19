class ApplicationController < ActionController::Base

    helper_method :current_user

    def require_signed_in
        if !user_signed_in?
            #TODO: Add flash alert
            redirect_to login_path
        end
    end

    def redirect_if_signed_in
        if user_signed_in?
            redirect_to home_path
        end
    end

    def user_signed_in?
        !!session[:user_id]
    end

    def current_user
        @user ||= User.find(session[:user_id])
    end

    def current_spotify_user
        @spotify_user ||= RSpotify::User.new(current_user.to_rspotify_hash)
    end

end
