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

ActiveRecord::Schema.define(version: 20160201013048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.float    "close"
    t.integer  "kazoo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "sma"
    t.float    "open"
    t.float    "low"
    t.float    "high"
  end

  add_index "days", ["kazoo_id"], name: "index_days_on_kazoo_id", using: :btree

  create_table "equity_accounts", force: :cascade do |t|
    t.float  "total_equity"
    t.float  "core_equity"
    t.float  "profit_loss"
    t.string "risk"
  end

  create_table "holdings", force: :cascade do |t|
    t.float   "stop_loss"
    t.float   "profit_loss"
    t.integer "units"
    t.float   "buy_point"
  end

  create_table "kazoos", force: :cascade do |t|
    t.string   "ticker_name"
    t.string   "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "watchable"
    t.boolean  "buyable"
  end

  create_table "trades", force: :cascade do |t|
    t.boolean "buy"
    t.float   "price"
    t.integer "quantity"
    t.float   "dollars"
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
