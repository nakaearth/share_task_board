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

ActiveRecord::Schema.define(:version => 20130201154206) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "descriptoin"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "blog_templates", :force => true do |t|
    t.text     "body"
    t.string   "path"
    t.string   "format"
    t.string   "locale"
    t.string   "handler"
    t.boolean  "partial"
    t.integer  "blog_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "blog_template_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "grade_masters", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "job_count",  :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "level",      :default => 1, :null => false
  end

  add_index "grade_masters", ["job_count"], :name => "index_grade_masters_on_job_count"

  create_table "group_maps", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "group_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "title",       :default => "", :null => false
    t.text     "description", :default => "", :null => false
    t.integer  "status",      :default => 1,  :null => false
    t.integer  "priority",    :default => 0,  :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "public_flag", :default => 0
    t.integer  "r_user_id",   :default => 0,  :null => false
    t.integer  "group_id",    :default => 0,  :null => false
  end

  add_index "jobs", ["r_user_id"], :name => "index_tasks_on_r_user_id"
  add_index "jobs", ["status", "priority"], :name => "index_tasks_on_status_and_priority"
  add_index "jobs", ["status", "public_flag"], :name => "index_tasks_on_status_and_public_flag"
  add_index "jobs", ["user_id", "group_id"], :name => "index_jobs_on_user_id_and_group_id"

  create_table "user_grades", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "grade_master_id", :default => 1, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "user_grades", ["user_id"], :name => "index_user_grades_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "last_sign_in_ip"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "screen_name"
    t.string   "image"
  end

end
