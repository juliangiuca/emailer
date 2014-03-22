class Bootstrap < ActiveRecord::Migration
  def change
    create_table "contacts", force: true do |t|
      t.integer  "user_id"
      t.string   "name"
      t.string   "email_address"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "contacts_groups", force: true do |t|
      t.integer  "group_id"
      t.integer  "contact_id"
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

    create_table "groups", force: true do |t|
      t.integer  "user_id"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
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
end
