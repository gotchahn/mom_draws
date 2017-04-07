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

ActiveRecord::Schema.define(version: 20170407172647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "ticket_id"
    t.datetime "completed_at"
    t.decimal  "goal"
    t.decimal  "ticket_price"
    t.integer  "user_id"
    t.string   "avatar_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.decimal  "amount"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "expenses", ["event_id"], name: "index_expenses_on_event_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "sponsor_donations", force: :cascade do |t|
    t.integer  "sponsor_id"
    t.text     "description"
    t.decimal  "amount"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sponsor_donations", ["event_id"], name: "index_sponsor_donations_on_event_id", using: :btree
  add_index "sponsor_donations", ["sponsor_id"], name: "index_sponsor_donations_on_sponsor_id", using: :btree

  create_table "sponsors", force: :cascade do |t|
    t.text     "name"
    t.text     "email"
    t.text     "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "events", "users"
  add_foreign_key "expenses", "events"
  add_foreign_key "expenses", "users"
  add_foreign_key "sponsor_donations", "events"
  add_foreign_key "sponsor_donations", "sponsors"
end
