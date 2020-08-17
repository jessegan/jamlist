class UsersController < ApplicationController

    ## Spotify
    # Callback route.
    # Handles Spotify authentication and redirects to either home page or create user page
    def spotify
        # Find if there is already an account with the same Spotify I
        if User.exists?(spotify_id: auth_params['id'])
            # If yes, find that user, update their images url and email, save user_id in sessions THEN redirect to home page

        else  
         # If no, render create account form with params
            @user = User.new(email: auth_params_info['email'], spotify_id: auth_params_info['id'], image: auth_params_info['images'][0]['url'], display_name:  auth_params_info['display_name'])
            @user.build_credential(auth_params_credentials)

            render 'new'
        end
    end

    private

    def auth_params
        request.env['omniauth.auth']
    end

    def auth_params_info
        auth_params[:info]
    end

    def auth_params_credentials
        auth_params['credentials'].permit!
    end


end
