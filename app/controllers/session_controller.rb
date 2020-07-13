class SessionController < ApplicationController
    def new
        redirect_to user_path(current_user) if current_user
        @user = User.new
    end

    def create
        if request.env['PATH_INFO'] == '/auth/facebook/callback' #If user logs in with Facebook
            @user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['email']
                u.display_name = auth['info']['name']
                u.password = "fakepasswordlol"
                u.password_confirmation = "fakepasswordlol"
            end
           
            session[:user_id] = @user.id

            puts @user.valid? #false

            @user.errors.full_messages.each do |msg|
                puts msg #fails all validations based around password
            end
        else #If user uses my login (works 100%)
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
