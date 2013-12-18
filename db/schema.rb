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

ActiveRecord::Schema.define(:version => 20131026201035) do

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "delegation_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_policies", :force => true do |t|
    t.string   "name"
    t.text     "sample",     :limit => 255
    t.text     "hint",       :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "defaultphases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "content"
  end

  create_table "designations", :force => true do |t|
    t.string   "role"
    t.string   "responsibility"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "membership_id"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "start_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_at"
    t.integer  "project_id"
    t.string   "content"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta", :force => true do |t|
    t.text     "stream_xml",    :limit => 255
    t.text     "structure_xml", :limit => 255
    t.text     "space_xml",     :limit => 255
    t.text     "scenario_xml",  :limit => 255
    t.text     "society_xml",   :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "start"
    t.datetime "end"
    t.string   "site"
    t.date     "planned_start_date"
    t.date     "planned_end_date"
  end

  create_table "policies", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "sample"
    t.string   "hint"
    t.integer  "default_policy_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "money"
    t.string   "funding_agency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "description"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "content"
    t.integer  "resourceable_id"
    t.string   "resourceable_type"
    t.string   "resourcer"
  end

  create_table "shipping_logs", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "shipped_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "priority"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "content"
    t.date     "start_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "homepage"
    t.string   "contact"
    t.integer  "invitation_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
