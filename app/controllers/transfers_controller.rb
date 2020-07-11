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
        @transfer = Transfer.create(transfer_params)

        puts @transfer.sender == current_user
        puts @transfer.amount > current_user.balance

        if @transfer.sender == current_user && @transfer.amount > current_user.balance
            @transfer.destroy
            redirect_to edit_user_path(current_user)
        else
            current_user.update_attribute(:balance, current_user.balance - @transfer.amount)
            redirect_to user_path(current_user)
        end
    end

    def transfer_params
        params.require(:transfer).permit(:receiver_id, :sender_id, :amount, :note, :status)
    end
end