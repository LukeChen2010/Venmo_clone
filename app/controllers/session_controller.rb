class SessionController < ApplicationController
    def new
        redirect_to user_path(current_user) if current_user
        @user = User.new
    end

    def create
        if request.env['PATH_INFO'] == '/auth/facebook/callback' #If user logs in with Facebook
            fake_password = (0...8).map { (65 + rand(26)).chr }.join
            puts fake_password

            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.username = auth['info']['email']
                u.display_name = auth['info']['name']
                u.password = fake_password
                u.password_confirmation = fake_password
            end
           
            session[:user_id] = @user.id
        else
            @user = User.find_by(username: params[:user][:username])

            if !@user 
                message = "Your login credentials are invalid!"
                redirect_to '/signin', flash: { message: message }
            elsif !@user.authenticate(params[:user][:password])
                message = "Your login credentials are invalid!"
                redirect_to '/signin', flash: { message: message }
            else
                session[:user_id] = @user.id
            end
        end

        redirect_to user_path(@user)
    end

    def delete
        session.delete("user_id")
        redirect_to root_path
    end

    private
 
    def auth
        request.env['omniauth.auth']
    end
end
