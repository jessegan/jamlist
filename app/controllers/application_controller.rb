class ApplicationController < ActionController::Base

    helper_method :current_user, :user_signed_in?, :current_group, :member_of, :admin_of, :owner_of

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
        @spotify_user ||= current_user.rspotify_user
    end

    ## logout
    # delete's the user_id from session
    def logout
        session.delete :user_id
    end

    ### Groups methods

    # Returns the current group based on params
    # @return [Group] the current group
    # @note This method is defined in subclasses
    def current_group
    end

    # Checks if the current user is a member of a given group
    # @param group [Group] the group to check members in
    # @return [boolean] the result of member check
    def member_of(group)
        current_user.is_member?(group)
    end

    # Checks if the current user is the owner of a group
    # @param group [Group] the group to check owner of
    # @return [boolean] the result of owner check
    def owner_of(group)
        current_user.is_owner?(group)
    end

    # Checks if the current user is an admin of a group
    # @param group [Group] the group to check admin of
    # @return [boolean] the result of admin check
    def admin_of(group)
        current_user.is_admin?(group)
    end

    # Redirects back if current user is not a member of the current group
    def require_member_of_group
        if !member_of(current_group)
            # TODO: Add flash alert
            redirect_back fallback_location: home_path
        end
    end

    # Redirects back if the current user is not a member of the current group if the group is private
    def require_member_of_group_if_private
        if !current_group.public
            require_member_of_group
        end
    end

    # Redirects back if the current user is not an admin of the current group
    def require_admin_of_group
        if !admin_of(current_group)
            # TODO: add flash alert
            redirect_back fallback_location: current_group
        end
    end

end
