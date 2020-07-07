class StaticController < ApplicationController
    def home
        @user = current_user
        render :layout => "application"
    end
end
