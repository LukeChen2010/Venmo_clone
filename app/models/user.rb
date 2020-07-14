class User < ApplicationRecord
    has_secure_password

    has_many :receiving_transfers, foreign_key: "receiver_id", class_name: "Transfer"
    has_many :users_received_from, through: :receiving_transfers, source: :sender

    has_many :sending_transfers, foreign_key: "sender_id", class_name: "Transfer"
    has_many :users_sent_to, through: :sending_transfers, source: :receiver

    validates :username, presence: true
    validates :username, uniqueness: true
    validates :display_name, presence: true
    validates :password, presence: true
    
    validates :username, length: { minimum: 5 }
    validates :display_name, length: { minimum: 5 }
    validates :password, length: { minimum: 8 }

    validates :balance, numericality: { greater_than_or_equal_to: 0 }

    def transfers
        return (self.receiving_transfers + self.sending_transfers).sort_by {|x| x.updated_at}.reverse
    end

    def interacted_users_transfers
        users = (self.users_received_from + self.users_sent_to).to_a
        return (Transfer.where(sender: users).where.not(receiver: self) + Transfer.where(receiver: users).where.not(sender: self)).uniq.sort_by {|x| x.updated_at}.reverse
    end
end

