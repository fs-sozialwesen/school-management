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

ActiveRecord::Schema.define(version: 20150828155758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriers", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "contact_person"
    t.string   "homepage"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "education_subject_id"
  end

  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree

  create_table "education_subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.text     "comments"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "course_id"
    t.integer  "education_subject_id"
    t.integer  "year"
    t.string   "street"
    t.string   "zip",                  limit: 10
    t.string   "city"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "street"
    t.string   "zip",        limit: 10
    t.string   "city"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "courses", "teachers"
end
