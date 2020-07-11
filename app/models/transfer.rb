class Transfer < ApplicationRecord
    belongs_to :receiver, class_name: "User" 
    belongs_to :sender, class_name: "User"

    validates :amount, presence: true
    validates :note, presence: true

    validates :amount, numericality: { greater_than_or_equal_to: 0 }
end