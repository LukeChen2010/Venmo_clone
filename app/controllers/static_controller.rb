class StaticController < ApplicationController
    def home 
        user = current_user
        sort_by = params['sort_by']

        @transfers = user.interacted_users_transfers.return_sorted(sort_by)
        render :layout => "application"
    end
end
