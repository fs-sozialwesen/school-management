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

ActiveRecord::Schema.define(version: 20151102054622) do

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

  create_table "course_memberships", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_memberships", ["course_id"], name: "index_course_memberships_on_course_id", using: :btree
  add_index "course_memberships", ["student_id"], name: "index_course_memberships_on_student_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "education_subject_id"
  end

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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "carrier_address", default: true
  end

  add_index "institutions", ["carrier_id"], name: "index_institutions_on_carrier_id", using: :btree

  create_table "internship_offers", force: :cascade do |t|
    t.string   "name"
    t.integer  "carrier_id"
    t.text     "description"
    t.string   "email"
    t.string   "work_area"
    t.string   "city"
    t.string   "street"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.string   "homepage"
    t.string   "contact_person"
    t.boolean  "accommodation"
    t.text     "accommodation_details"
    t.text     "application_documents"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "type"
    t.integer  "internship_offer_id"
    t.integer  "education_subject_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "number_of_positions",   default: 1
    t.jsonb    "application_options"
  end

  add_index "internship_offers", ["carrier_id"], name: "index_internship_offers_on_carrier_id", using: :btree
  add_index "internship_offers", ["education_subject_id"], name: "index_internship_offers_on_education_subject_id", using: :btree
  add_index "internship_offers", ["internship_offer_id"], name: "index_internship_offers_on_internship_offer_id", using: :btree

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
    t.integer  "education_subject_id"
  end

  add_index "internship_positions", ["education_subject_id"], name: "index_internship_positions_on_education_subject_id", using: :btree
  add_index "internship_positions", ["institution_id"], name: "index_internship_positions_on_institution_id", using: :btree

  create_table "internships", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "internship_position_id"
    t.integer  "mentor_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "state"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "internships", ["internship_position_id"], name: "index_internships_on_internship_position_id", using: :btree

  create_table "legacy_data", force: :cascade do |t|
    t.string   "old_table"
    t.integer  "old_id"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "room_id"
    t.string   "comments"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "course_id"
    t.date     "date"
    t.string   "state"
    t.integer  "time_block_id"
  end

  add_index "lessons", ["room_id"], name: "index_lessons_on_room_id", using: :btree
  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id", using: :btree
  add_index "lessons", ["teacher_id"], name: "index_lessons_on_teacher_id", using: :btree
  add_index "lessons", ["time_block_id"], name: "index_lessons_on_time_block_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "gender"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_blocks", force: :cascade do |t|
    t.integer  "start_hour"
    t.integer  "start_minute"
    t.integer  "end_hour"
    t.integer  "end_minute"
    t.integer  "position"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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

  add_foreign_key "course_memberships", "courses"
  add_foreign_key "institutions", "carriers"
  add_foreign_key "internship_offers", "carriers"
  add_foreign_key "internship_offers", "education_subjects"
  add_foreign_key "internship_offers", "internship_offers"
  add_foreign_key "internship_positions", "education_subjects"
  add_foreign_key "internship_positions", "institutions"
  add_foreign_key "internships", "internship_positions"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "rooms"
  add_foreign_key "lessons", "subjects"
  add_foreign_key "lessons", "time_blocks"
end
