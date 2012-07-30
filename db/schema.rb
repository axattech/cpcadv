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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120730042149) do

  create_table "admin_users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.datetime "last_login"
    t.datetime "created_at"
    t.string   "salt_password",   :limit => 100
  end

  create_table "categories", :force => true do |t|
    t.string   "category_name"
    t.boolean  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "ccode"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_salt"
    t.integer  "country_id"
    t.string   "provider"
    t.boolean  "status",        :default => true, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "password_hash"
    t.string   "gender"
    t.integer  "age"
    t.boolean  "member_detail", :default => true
  end

  create_table "offers", :force => true do |t|
    t.string   "offer_name"
    t.string   "offer_link"
    t.text     "offer_description"
    t.text     "offer_msg"
    t.integer  "offer_budget"
    t.integer  "offer_cr_per_click"
    t.integer  "offer_max_clicks_per_user"
    t.string   "offer_start_date",          :limit => 50
    t.string   "offer_end_date",            :limit => 50
    t.boolean  "offer_worldwide",                         :default => false
    t.boolean  "offer_status"
    t.integer  "category_id"
    t.integer  "country_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "member_id"
    t.boolean  "payment_status",                          :default => false, :null => false
  end

  add_index "offers", ["category_id"], :name => "index_offers_on_category_id"
  add_index "offers", ["country_id"], :name => "index_offers_on_country_id"
  add_index "offers", ["member_id"], :name => "index_offers_on_member_id"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "offer_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "topup_payments", :force => true do |t|
    t.integer  "offers_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topup_payments", ["offers_id"], :name => "index_topup_payments_on_offers_id"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
