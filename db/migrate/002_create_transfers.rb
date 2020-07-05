class CreateTransfers < ActiveRecord::Migration[5.2]
    def change
        create_table :transfers do |t|
            t.decimal :amount
            t.string :note
            t.string :status
            t.references :receiver
            t.references :sender
      
            t.timestamps null: false
        end
    end
end