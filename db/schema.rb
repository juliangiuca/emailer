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

ActiveRecord::Schema.define(version: 13) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.boolean  "sent"
    t.integer  "user_id"
  end

  create_table "tracking_pixels", force: true do |t|
    t.string   "tracking"
    t.integer  "contact_id"
    t.integer  "email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views",             default: 0
    t.datetime "date_first_viewed"
    t.datetime "sent"
    t.integer  "time_viewed",       default: 0
  end

  create_table "user_agents", force: true do |t|
    t.integer  "tracking_pixel_id"
    t.string   "agent",             limit: 1000
    t.string   "referer",           limit: 1000
    t.datetime "created_at"
  end

  create_table "users", force: true do |t|
    t.string "name"
    t.string "email_address"
  end

end
