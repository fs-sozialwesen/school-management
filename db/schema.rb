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

ActiveRecord::Schema.define(version: 20160407092902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "admins", ["person_id"], name: "index_admins_on_person_id", using: :btree

  create_table "candidates", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "active"
    t.jsonb    "options",                      default: {}
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "status",                       default: 0
    t.date     "date"
    t.text     "notes"
    t.string   "education_subject"
    t.integer  "year"
    t.jsonb    "school_graduate",              default: {}
    t.jsonb    "profession_graduate",          default: {}
    t.text     "internships"
    t.boolean  "internships_proved",           default: false
    t.jsonb    "interview",                    default: {}
    t.boolean  "police_certificate",           default: false
    t.date     "education_contract_sent"
    t.date     "education_contract_received"
    t.date     "internship_contract_sent"
    t.date     "internship_contract_received"
    t.date     "cancel_date"
    t.text     "cancel_reason"
    t.boolean  "debit_mandate",                default: false
    t.text     "contract_notes"
  end

  add_index "candidates", ["person_id"], name: "index_candidates_on_person_id", using: :btree

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
    t.string   "name",       null: false
    t.integer  "teacher_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree

  create_table "education_subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enums", force: :cascade do |t|
    t.string "name",  null: false
    t.string "value"
  end

  add_index "enums", ["name"], name: "index_enums_on_name", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.integer  "organisation_id"
    t.text     "description"
    t.string   "work_area"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "positions_count", default: 1
    t.jsonb    "address",         default: {}
    t.jsonb    "contact",         default: {}
    t.jsonb    "housing",         default: {}
    t.jsonb    "applying",        default: {}
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "in_search",       default: true
  end

  add_index "institutions", ["organisation_id"], name: "index_institutions_on_organisation_id", using: :btree

  create_table "internship_positions", force: :cascade do |t|
    t.string   "name"
    t.integer  "organisation_id"
    t.text     "description"
    t.string   "work_area"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "positions_count", default: 1
    t.jsonb    "address",         default: {}
    t.jsonb    "contact",         default: {}
    t.jsonb    "housing",         default: {}
    t.jsonb    "applying",        default: {}
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "internship_positions", ["organisation_id"], name: "index_internship_positions_on_organisation_id", using: :btree

  create_table "internships", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "internship_position_id"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "comments"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "mentor_id"
    t.integer  "institution_id"
  end

  add_index "internships", ["institution_id"], name: "index_internships_on_institution_id", using: :btree
  add_index "internships", ["internship_position_id"], name: "index_internships_on_internship_position_id", using: :btree
  add_index "internships", ["mentor_id"], name: "index_internships_on_mentor_id", using: :btree
  add_index "internships", ["student_id"], name: "index_internships_on_student_id", using: :btree

  create_table "legacy_data", force: :cascade do |t|
    t.string   "old_table"
    t.integer  "old_id"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "time_table_id"
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "room_id"
    t.integer  "time_block_id"
    t.integer  "weekday"
    t.string   "comments"
    t.string   "color"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "lessons", ["room_id"], name: "index_lessons_on_room_id", using: :btree
  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id", using: :btree
  add_index "lessons", ["teacher_id"], name: "index_lessons_on_teacher_id", using: :btree
  add_index "lessons", ["time_block_id"], name: "index_lessons_on_time_block_id", using: :btree
  add_index "lessons", ["time_table_id"], name: "index_lessons_on_time_table_id", using: :btree

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
    t.date     "blocked_at"
  end

  add_index "logins", ["confirmation_token"], name: "index_logins_on_confirmation_token", unique: true, using: :btree
  add_index "logins", ["email"], name: "index_logins_on_email", unique: true, using: :btree
  add_index "logins", ["person_id"], name: "index_logins_on_person_id", using: :btree
  add_index "logins", ["reset_password_token"], name: "index_logins_on_reset_password_token", unique: true, using: :btree

  create_table "managers", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "managers", ["person_id"], name: "index_managers_on_person_id", using: :btree

  create_table "mentors", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "mentors", ["organisation_id"], name: "index_mentors_on_organisation_id", using: :btree
  add_index "mentors", ["person_id"], name: "index_mentors_on_person_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "kind"
    t.integer  "carrier_id"
    t.text     "comments"
    t.jsonb    "address",    default: {}
    t.jsonb    "contact",    default: {}
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "course_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students", ["course_id"], name: "index_students_on_course_id", using: :btree
  add_index "students", ["person_id"], name: "index_students_on_person_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "teachers", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teachers", ["person_id"], name: "index_teachers_on_person_id", using: :btree

  create_table "time_blocks", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_tables", force: :cascade do |t|
    t.integer  "course_id"
    t.date     "start_date"
    t.text     "comments"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "activated_at"
  end

  add_index "time_tables", ["course_id"], name: "index_time_tables_on_course_id", using: :btree

  create_table "timetable_documents", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "year"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

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

  add_foreign_key "admins", "people"
  add_foreign_key "candidates", "people"
  add_foreign_key "course_memberships", "courses"
  add_foreign_key "courses", "teachers"
  add_foreign_key "institutions", "organisations"
  add_foreign_key "internship_positions", "organisations"
  add_foreign_key "internships", "institutions"
  add_foreign_key "internships", "internship_positions"
  add_foreign_key "internships", "mentors"
  add_foreign_key "internships", "students"
  add_foreign_key "lessons", "rooms"
  add_foreign_key "lessons", "subjects"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "lessons", "time_blocks"
  add_foreign_key "lessons", "time_tables"
  add_foreign_key "logins", "people"
  add_foreign_key "managers", "people"
  add_foreign_key "mentors", "organisations"
  add_foreign_key "mentors", "people"
  add_foreign_key "students", "courses"
  add_foreign_key "students", "people"
  add_foreign_key "teachers", "people"
  add_foreign_key "time_tables", "courses"
end
