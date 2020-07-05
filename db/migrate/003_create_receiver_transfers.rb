class CreateReceiverTransfers < ActiveRecord::Migration[5.2]
    def change
        create_table :receiver_transfers do |t|
            t.integer :user_id
            t.integer :transfer_id
        end
    end
end