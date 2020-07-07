class TransfersController < ApplicationController
    
    def request_payment
        @transfer = Transfer.new

        @receiver = current_user
        @sender = User.find_by(id: params[:user_id])

        #If user attempts to send money to themself
        if @receiver && @sender && @receiver.id == @sender.id
            redirect_to root_url 
        else
            render 'new'
        end
    end

    def send_payment
        @transfer = Transfer.new

        @receiver = User.find_by(id: params[:user_id])
        @sender = current_user

         #If user attempts to send money to themself
        if @receiver && @sender && @receiver.id == @sender.id
            redirect_to root_url 
        else
            render 'new'
        end
    end

    def create
        
    end
end