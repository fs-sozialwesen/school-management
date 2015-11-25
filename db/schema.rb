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

ActiveRecord::Schema.define(version: 20151124061814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.string   "type"
    t.integer  "role_id"
    t.integer  "first_party_id"
    t.string   "first_party_type"
    t.integer  "second_party_id"
    t.string   "second_party_type"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "text"
    t.text     "comments"
    t.string   "state"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "contracts", ["first_party_type", "first_party_id"], name: "index_contracts_on_first_party_type_and_first_party_id", using: :btree
  add_index "contracts", ["role_id"], name: "index_contracts_on_role_id", using: :btree
  add_index "contracts", ["second_party_type", "second_party_id"], name: "index_contracts_on_second_party_type_and_second_party_id", using: :btree

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
    t.string   "name",                 null: false
    t.integer  "education_subject_id"
    t.integer  "teacher_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "courses", ["education_subject_id"], name: "index_courses_on_education_subject_id", using: :btree
  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree

  create_table "education_subjects", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "education_subjects", ["school_id"], name: "index_education_subjects_on_school_id", using: :btree

  create_table "internship_positions", force: :cascade do |t|
    t.string   "name"
    t.integer  "organisation_id"
    t.integer  "education_subject_id"
    t.text     "description"
    t.string   "work_area"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "positions_count",      default: 1
    t.jsonb    "address",              default: {}
    t.jsonb    "contact",              default: {}
    t.jsonb    "housing",              default: {}
    t.jsonb    "applying",             default: {}
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "internship_positions", ["education_subject_id"], name: "index_internship_positions_on_education_subject_id", using: :btree
  add_index "internship_positions", ["organisation_id"], name: "index_internship_positions_on_organisation_id", using: :btree

  create_table "legacy_data", force: :cascade do |t|
    t.string   "old_table"
    t.integer  "old_id"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.integer  "person_id"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "logins", ["confirmation_token"], name: "index_logins_on_confirmation_token", unique: true, using: :btree
  add_index "logins", ["email"], name: "index_logins_on_email", unique: true, using: :btree
  add_index "logins", ["person_id"], name: "index_logins_on_person_id", using: :btree
  add_index "logins", ["reset_password_token"], name: "index_logins_on_reset_password_token", unique: true, using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "type",       default: "Organisation"
    t.string   "name",                                null: false
    t.string   "kind"
    t.integer  "carrier_id"
    t.text     "comments"
    t.jsonb    "address",    default: {}
    t.jsonb    "contact",    default: {}
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "organisations", ["carrier_id"], name: "index_organisations_on_carrier_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "first_name",                  null: false
    t.string   "last_name",                   null: false
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.jsonb    "address",        default: {}
    t.jsonb    "contact",        default: {}
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.string   "type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.jsonb    "options",         default: {}
  end

  add_index "roles", ["organisation_id"], name: "index_roles_on_organisation_id", using: :btree
  add_index "roles", ["person_id"], name: "index_roles_on_person_id", using: :btree
  add_index "roles", ["type"], name: "index_roles_on_type", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "contracts", "roles"
  add_foreign_key "course_memberships", "courses"
  add_foreign_key "courses", "education_subjects"
  add_foreign_key "internship_positions", "education_subjects"
  add_foreign_key "internship_positions", "organisations"
  add_foreign_key "logins", "people"
  add_foreign_key "roles", "organisations"
  add_foreign_key "roles", "people"
end
