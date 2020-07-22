class Transfer < ApplicationRecord
    belongs_to :receiver, class_name: "User" 
    belongs_to :sender, class_name: "User"

    validates :amount, presence: true
    validates :note, presence: true

    validates :amount, numericality: { greater_than_or_equal_to: 0 }

    def self.return_sorted(order)
        if order == "ascending"
            return self.order(updated_at: :asc)
        else
            return self.order(updated_at: :desc)
        end
    end
end