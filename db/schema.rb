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

ActiveRecord::Schema[7.0].define(version: 2023_08_03_032750) do
  create_table "achievements", charset: "utf8", force: :cascade do |t|
    t.text "achievement_text"
    t.integer "commission_count", default: 0, null: false
    t.text "text"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chats", charset: "utf8", force: :cascade do |t|
    t.text "post_text", null: false
    t.bigint "user_id", null: false
    t.bigint "dealing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealing_id"], name: "index_chats_on_dealing_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "commissions", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.date "limit_date", null: false
    t.integer "reward", null: false
    t.boolean "directly", default: false, null: false
    t.bigint "contractor_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["contractor_id"], name: "index_commissions_on_contractor_id"
    t.index ["user_id"], name: "index_commissions_on_user_id"
  end

  create_table "dealings", charset: "utf8", force: :cascade do |t|
    t.bigint "commission_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_id"], name: "index_dealings_on_commission_id"
    t.index ["user_id"], name: "index_dealings_on_user_id"
  end

  create_table "notifications", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "commission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_id"], name: "index_notifications_on_commission_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achievements", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chats", "dealings"
  add_foreign_key "chats", "users"
  add_foreign_key "commissions", "users"
  add_foreign_key "dealings", "commissions"
  add_foreign_key "dealings", "users"
  add_foreign_key "notifications", "commissions"
  add_foreign_key "notifications", "users"
end
