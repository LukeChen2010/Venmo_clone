class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        username = params[:user][:username]
        display_name = params[:user][:display_name]
        password = params[:user][:password]
        password_confirm = params[:user][:password_confirm]

        if username == "" ||  display_name == "" ||  password == "" ||  password_confirm == ""
            message = "Please fill in all required fields!"
            redirect_to "/users/new", flash: { message: message }
        elsif User.find_by(username: username)
            message = "Username #{username} has already been taken!"
            redirect_to "/users/new", flash: { message: message }
        elsif password != password_confirm
            message = "Passwords do not match!"
            redirect_to "/users/new", flash: { message: message }
        else
            @user = User.create(user_params)
            session[:user_id] = @user.id
            redirect_to user_path(@user)                  
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