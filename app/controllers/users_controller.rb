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

        @user = User.create(user_params)

        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            @user.password = ""
            @user.password_confirmation = ""
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
        add_funds = params[:user][:add_funds].to_f.round(2)

        @user.update_attribute(:balance, @user.balance + add_funds) if add_funds > 0
        
        redirect_to edit_user_path(@user)
    end

    private
 
    def user_params
        params.require(:user).permit(:username, :display_name, :password, :password_confirmation)
    end
end