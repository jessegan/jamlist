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
            @user.build_credential(token: auth_params_credentials[:token], refresh_token: auth_params_credentials[:refresh_token], expires_at: auth_params_credentials[:expires_at], expires: auth_params_credentials[:expires])

            render 'new'
        end
    end

    ## create
    # Create user route
    # Will create a user and redirect to home page
    def create
        binding.pry
        @user = User.new(user_params)
        if @user.save
            @user.create_credential(credential_params)

            session[:user_id] = @user.id

            redirect_to root_path
        else
            flash[:error] = @user.errors.full_messages
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
        auth_params['credentials']
    end

    def user_params
        params.require(:user).permit(:email,:display_name,:image,:spotify_id,:password,:password_confirmation)
    end

    def credential_params
        params.require(:user).permit(credential_attributes: [:token,:refresh_token,:expires_at,:expires])
    end

end
