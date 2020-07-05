class SessionController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(username: params[:user][:username])

        if !@user 
            message = "Your login credentials are invalid!"
            redirect_to '/signin', flash: { message: message }
        elsif !@user.authenticate(params[:user][:password])
            message = "Your login credentials are invalid!"
            redirect_to '/signin', flash: { message: message }
        else
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        end
    end

    def delete
        session.delete("user_id")
        redirect_to root_path
    end
end
