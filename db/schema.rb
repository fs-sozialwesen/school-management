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

ActiveRecord::Schema.define(version: 20150918215814) do

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
    t.string   "short_name"
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.integer  "carrier_id"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "county"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "contact_person"
    t.string   "homepage"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "institutions", ["carrier_id"], name: "index_institutions_on_carrier_id", using: :btree

  create_table "internship_positions", force: :cascade do |t|
    t.string   "name"
    t.integer  "institution_id"
    t.string   "work_area"
    t.text     "description"
    t.boolean  "accommodation"
    t.integer  "kind_of_application"
    t.integer  "year"
    t.string   "application_documents"
    t.string   "contact_person"
    t.text     "comments"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "internship_positions", ["institution_id"], name: "index_internship_positions_on_institution_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.integer  "time_table_id"
    t.string   "subject"
    t.integer  "teacher_id"
    t.string   "block"
    t.string   "room"
    t.text     "comments"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "lessons", ["teacher_id"], name: "index_lessons_on_teacher_id", using: :btree
  add_index "lessons", ["time_table_id"], name: "index_lessons_on_time_table_id", using: :btree

  create_table "mentors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "carrier_id"
    t.integer  "institution_id"
    t.string   "email"
    t.string   "phone"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "mentors", ["carrier_id"], name: "index_mentors_on_carrier_id", using: :btree
  add_index "mentors", ["institution_id"], name: "index_mentors_on_institution_id", using: :btree

  create_table "practice_guides", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "carrier_id"
    t.integer  "institution_id"
    t.string   "email"
    t.string   "phone"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "practice_guides", ["carrier_id"], name: "index_practice_guides_on_carrier_id", using: :btree
  add_index "practice_guides", ["institution_id"], name: "index_practice_guides_on_institution_id", using: :btree

  create_table "practice_leaders", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "carrier_id"
    t.integer  "institution_id"
    t.string   "email"
    t.string   "phone"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "practice_leaders", ["carrier_id"], name: "index_practice_leaders_on_carrier_id", using: :btree
  add_index "practice_leaders", ["institution_id"], name: "index_practice_leaders_on_institution_id", using: :btree

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

  create_table "time_tables", force: :cascade do |t|
    t.integer  "course_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "time_tables", ["course_id"], name: "index_time_tables_on_course_id", using: :btree

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
    t.integer  "loginable_id"
    t.string   "loginable_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["loginable_id"], name: "index_users_on_loginable_id", using: :btree
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
  add_foreign_key "institutions", "carriers"
  add_foreign_key "internship_positions", "institutions"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "lessons", "time_tables"
  add_foreign_key "mentors", "carriers"
  add_foreign_key "mentors", "institutions"
  add_foreign_key "practice_guides", "carriers"
  add_foreign_key "practice_guides", "institutions"
  add_foreign_key "practice_leaders", "carriers"
  add_foreign_key "practice_leaders", "institutions"
  add_foreign_key "time_tables", "courses"
end
