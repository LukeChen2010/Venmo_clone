class UsersController < ApplicationController

    def new
        redirect_to root_url if current_user
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
            render 'new'          
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        display_name = params[:user][:display_name]
        add_funds = params[:user][:add_funds].to_f.round(2)

        @user.update(display_name: display_name)

        if add_funds > 0
            @user.update(balance: @user.balance + add_funds)
        end
        
        redirect_to user_path(@user)
    end

    private
 
    def user_params
        params.require(:user).permit(:username, :display_name, :password, :password_confirmation)
    end
end