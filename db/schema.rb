# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 4) do

  create_table "receiver_transfers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "transfer_id"
  end

  create_table "sender_transfers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "transfer_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount"
    t.string "note"
    t.string "transfer_type"
    t.string "status"
    t.integer "receiver_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "display_name"
    t.decimal "balance", default: "0.0"
    t.string "password_digest"
    t.integer "receiver_transfer_id"
    t.integer "sender_transfer_id"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_transfer_id"], name: "index_users_on_receiver_transfer_id"
    t.index ["sender_transfer_id"], name: "index_users_on_sender_transfer_id"
  end

end
