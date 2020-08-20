class UsersController < ApplicationController

    ### CALLBACKS

    before_action :redirect_if_signed_in, only: [:spotify]
    before_action :require_signed_in, :set_user, only: [:show,:edit,:update,:destroy]


    ## Spotify
    # Callback route.
    # Handles Spotify authentication and redirects to either home page or create user page
    def spotify
        # Find if there is already an account with the same Spotify

        if User.exists?(spotify_id: auth_params_info['id'])
            session[:user_id] = User.find_by(spotify_id: auth_params_info['id']).id

            redirect_to home_path
        else  
         # If no, render create account form with params
            @user = User.new(email: auth_params_info['email'], spotify_id: auth_params_info['id'], image: auth_params_info['images'][0]['url'], display_name:  auth_params_info['display_name'])
            @user.build_credential(token: auth_params_credentials[:token], refresh_token: auth_params_credentials[:refresh_token], expires_at: auth_params_credentials[:expires_at], expires: auth_params_credentials[:expires])

            render 'new'
        end
    end

    ## create
    # Create user route
    # Will create a user and redirect to home page
    def create
        @user = User.new(user_params)
        if @user.save
            @user.create_credential(credential_params)

            session[:user_id] = @user.id

            redirect_to home_path
        else
            render 'new'
        end
    end

    ## show
    # show user route
    # shows a user's profile
    def show
    end

    private

    def auth_params
        request.env['omniauth.auth']
    end

    def auth_params_info
        auth_params[:info]
    end

    def auth_params_credentials
        auth_params['credentials']
    end

    def user_params
        params.require(:user).permit(:email,:display_name,:image,:spotify_id,:password,:password_confirmation)
    end

    def credential_params
        params.require(:user).require(:credential_attributes).permit(:token,:refresh_token,:expires_at,:expires)
    end

    ## set_user
    # sets @user to the user id given in params
    def set_user
        @user = User.find(params[:id])
    end

    ## viewing_current_user
    # checks to see if current user is viewing their own profile
    def viewing_current_user
        @user == current_user
    end

end