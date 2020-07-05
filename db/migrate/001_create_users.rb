class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
            t.string :username
            t.string :display_name
            t.decimal :balance, default: 0
            t.string :password_digest
            t.references :receiver_transfer
            t.references :sender_transfer

            t.boolean :admin, default: :false
      
            t.timestamps null: false
        end
    end
end