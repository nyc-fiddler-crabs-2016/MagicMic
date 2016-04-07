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

ActiveRecord::Schema.define(version: 20160404193412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcasts", force: :cascade do |t|
    t.string   "topic",                   null: false
    t.datetime "datetime"
    t.integer  "duration",   default: 60
    t.integer  "speaker_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "reminder_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "broadcast_id"
    t.boolean  "email_reminder",   default: false
    t.boolean  "text_message",     default: false
    t.boolean  "day_before_sent",  default: false, null: false
    t.boolean  "hour_before_sent", default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "reminder_settings", ["broadcast_id"], name: "index_reminder_settings_on_broadcast_id", using: :btree
  add_index "reminder_settings", ["user_id"], name: "index_reminder_settings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "email",           null: false
    t.string   "phone_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "reminder_settings", "broadcasts"
  add_foreign_key "reminder_settings", "users"
end
