# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_27_141419) do
  create_table "commissions", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.date "limit_date", null: false
    t.integer "reward", null: false
    t.boolean "directly", default: false, null: false
    t.bigint "contractor_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_commissions_on_contractor_id"
    t.index ["user_id"], name: "index_commissions_on_user_id"
  end

  create_table "notifications", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "commission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_id"], name: "index_notifications_on_commission_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reading_name", null: false
    t.string "postal_code", null: false
    t.string "prefectures", null: false
    t.string "city", null: false
    t.string "building_name", null: false
    t.string "financial_institution"
    t.string "branch"
    t.string "deposit"
    t.string "account_number"
    t.string "account_holder"
    t.string "rank", default: "D", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
  end

  add_foreign_key "commissions", "users"
  add_foreign_key "notifications", "commissions"
  add_foreign_key "notifications", "users"
end
