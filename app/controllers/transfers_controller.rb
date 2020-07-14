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

        if @transfer.sender == current_user && @transfer.amount > current_user.balance
            @transfer.destroy
            redirect_to edit_user_path(current_user), flash: { message: "Insufficient balance!" }
            return
        elsif @transfer.status == "completed"
            current_user.update_attribute(:balance, current_user.balance - @transfer.amount)
            @transfer.receiver.update_attribute(:balance, @transfer.receiver.balance + @transfer.amount)
        end

        redirect_to user_path(current_user)
    end

    def index
        @user = User.find_by(id: params[:user_id])
    end

    def show
        @transfer = Transfer.find_by(id: params[:id])
    end

    def accept
        @transfer = Transfer.find_by(id: params[:id])

        if @transfer.amount > current_user.balance
            redirect_to edit_user_path(current_user), flash: { message: "Insufficient balance!" }
        else
            @transfer.update_attribute(:status, "completed")
            current_user.update_attribute(:balance, current_user.balance - @transfer.amount)
            @transfer.receiver.update_attribute(:balance, @transfer.receiver.balance + @transfer.amount)
            redirect_to user_path(current_user)
        end
    end

    def withdraw
        @transfer = Transfer.find_by(id: params[:id])
        @transfer.update_attribute(:status, "withdrawn")
        redirect_to user_path(current_user)
    end

    private

    def transfer_params
        params.require(:transfer).permit(:receiver_id, :sender_id, :amount, :note, :status)
    end
end