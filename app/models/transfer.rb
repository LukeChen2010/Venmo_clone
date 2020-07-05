class Transfer < ActiveRecord::Base
    has_one :receiver_transfer
    has_one :sender_transfer
    has_one :receiver, through: :receiver_transfer, source: :user
    has_one :sender, through: :sender_transfer, source: :user
end