class User < ActiveRecord::Base
    has_secure_password
    has_many :receiver_transfers
    has_many :sender_transfers
    has_many :receiving_transfers, through: :receiver_transfers, source: :transfer
    has_many :sending_transfers, through: :sender_transfers, source: :transfer
    attr_accessor :entered_password, :password_confirm
end