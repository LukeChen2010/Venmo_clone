class SenderTransfer < ActiveRecord::Base
    belongs_to :user
    belongs_to :transfer
end