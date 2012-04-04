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

ActiveRecord::Schema.define(:version => 20120404032608) do

  create_table "logs", :force => true do |t|
    t.integer   "user_id"
    t.integer   "task_id"
    t.integer   "time"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "value"
  end

  create_table "microtasks", :force => true do |t|
    t.integer   "task_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "status",     :default => "incomplete"
  end

  create_table "situations", :force => true do |t|
    t.string    "name"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "task_contexts", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "task_id"
    t.integer   "situation_id"
  end

  create_table "tasks", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
    t.integer   "user_id"
    t.float     "weight"
    t.integer   "time",         :default => 600
    t.string    "description"
    t.string    "display_type"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "time_offset",                           :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
