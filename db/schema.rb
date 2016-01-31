# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160131064438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commodities", force: :cascade do |t|
    t.string   "name"
    t.float    "close"
    t.float    "sma50"
    t.float    "sell_point"
    t.float    "invest_point"
    t.boolean  "sma_cleared"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.float    "close"
    t.integer  "kazoo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "sma"
    t.float    "open"
  end

  add_index "days", ["kazoo_id"], name: "index_days_on_kazoo_id", using: :btree

  create_table "holdings", force: :cascade do |t|
    t.float    "buy_next_unit_at"
    t.float    "unit_1"
    t.datetime "unit_1_date"
    t.float    "unit_2"
    t.datetime "unit_2_date"
    t.float    "unit_3"
    t.datetime "unit_3_date"
    t.float    "unit_4"
    t.datetime "unit_4_date"
    t.float    "unit_5"
    t.datetime "unit_5_date"
    t.float    "stop_loss"
    t.datetime "stop_loss_time"
    t.float    "atr"
  end

  create_table "kazoos", force: :cascade do |t|
    t.string   "ticker_name"
    t.string   "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "watchable"
    t.boolean  "buyable"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
