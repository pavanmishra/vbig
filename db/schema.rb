# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100903092652) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "action",       :limit => 32, :default => "created"
    t.string   "info",                       :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "badge_users", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "event_users", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.decimal  "lat",                :precision => 10, :scale => 7
    t.decimal  "lng",                :precision => 10, :scale => 7
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.boolean  "featured"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "from"
    t.datetime "to"
  end

  add_index "events", ["lat", "lng"], :name => "index_events_on_lat_and_lng"

  create_table "invitations", :force => true do |t|
    t.string   "code"
    t.string   "email"
    t.boolean  "used"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_users", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.decimal  "lat",                                       :precision => 10, :scale => 7
    t.decimal  "lng",                                       :precision => 10, :scale => 7
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                      :limit => 40
    t.string   "email",                      :limit => 100
    t.string   "salt",                       :limit => 40
    t.string   "crypted_password",           :limit => 40
    t.string   "remember_token",             :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.integer  "facebook_user_id"
    t.integer  "facebook_access_token"
    t.integer  "points",                                                                   :default => 0
    t.string   "name"
    t.string   "sex"
    t.string   "profile_url"
    t.string   "pic_square"
    t.string   "locale"
    t.string   "middle_name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.text     "about_me"
    t.string   "fighting_for"
    t.boolean  "is_admin"
    t.boolean  "send_message_notifications"
    t.boolean  "send_weekly_updates"
    t.boolean  "send_newsletter"
  end

end
