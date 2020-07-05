class StaticController < ApplicationController
    def home
        render :layout => "application"
    end
end
