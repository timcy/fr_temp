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

ActiveRecord::Schema.define(version: 20150109063822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coaches", force: :cascade do |t|
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip",                                 limit: 6
    t.string   "phone_number"
    t.string   "cell_phone_number"
    t.boolean  "subscribe_to_sms_replies"
    t.boolean  "is_active"
    t.boolean  "is_compliance_officer"
    t.boolean  "is_admission_officer"
    t.boolean  "is_allowed_multiple_exports"
    t.boolean  "subscribe_to_athlete_questionnaires"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "university_id"
  end

  create_table "coaches_sports", id: false, force: :cascade do |t|
    t.integer "coach_id"
    t.integer "sport_id"
  end

  create_table "duties", force: :cascade do |t|
    t.integer  "owned_by_coach_id"
    t.string   "name",                 limit: 200
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "is_complete",                      default: false
    t.string   "urgency",              limit: 10
    t.string   "display_in"
    t.boolean  "send_reminder_emails",             default: false
    t.text     "notes"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "duties", ["owned_by_coach_id"], name: "index_duties_on_owned_by_coach_id", using: :btree
  add_index "duties", ["start_date", "end_date"], name: "index_duties_on_start_date_and_end_date", using: :btree

  create_table "duty_assignments", force: :cascade do |t|
    t.integer  "duty_id"
    t.integer  "assignable_id"
    t.string   "assignable_type"
    t.string   "category",        limit: 10
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "duty_assignments", ["duty_id", "assignable_id", "assignable_type"], name: "index_assigned_duties", using: :btree

  create_table "sports", force: :cascade do |t|
    t.integer  "university_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.integer  "role_id"
    t.string   "role_type",              limit: 20
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id", "role_type"], name: "index_user_roles", using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

end
