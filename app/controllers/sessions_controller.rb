class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: user_params[:email])
        if @user && @user.authenticate(user_params[:password])
            session[:user_id] = @user.id

            redirect_to root_path
        else
            render :new
        end
    end

    def logout
        session.destroy :user_id

        redirect_to root_path
    end

    private

    def user_params
        params.require(:user).permit(:email,:password)
    end

end
