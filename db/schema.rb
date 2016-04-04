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

ActiveRecord::Schema.define(version: 20160401213147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcasts", force: :cascade do |t|
    t.string   "topic",                                      null: false
    t.datetime "datetime",   default: '2016-04-04 01:15:06'
    t.integer  "duration",   default: 60
    t.integer  "speaker_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "user_broadcasts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "broadcast_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_broadcasts", ["broadcast_id"], name: "index_user_broadcasts_on_broadcast_id", using: :btree
  add_index "user_broadcasts", ["user_id"], name: "index_user_broadcasts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "user_broadcasts", "broadcasts"
  add_foreign_key "user_broadcasts", "users"
end
