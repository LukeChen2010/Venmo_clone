class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        username = params[:user][:username]
        display_name = params[:user][:display_name]
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]

        @user = User.create(username: username, display_name: display_name, password: password, password_confirmation: password_confirmation)

        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'users/new'          
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private
 
    def user_params
        params.require(:user).permit(:username, :display_name, :password, :password_confirmation)
    end
end