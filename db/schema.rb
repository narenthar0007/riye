# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_25_123900) do
  create_table "api_accesses", force: :cascade do |t|
    t.string "access_key", null: false
    t.string "secret_key"
    t.string "name"
    t.text "permissions"
    t.integer "user_id"
    t.datetime "last_used_at"
    t.datetime "expires_at"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_key"], name: "index_api_accesses_on_access_key", unique: true
    t.index ["user_id"], name: "index_api_accesses_on_user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.datetime "punch_in"
    t.datetime "punch_out"
    t.integer "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "punch_in_location"
    t.string "punch_out_location"
    t.boolean "approved", default: false
    t.index ["worker_id"], name: "index_attendances_on_worker_id"
  end

  create_table "bank_details", force: :cascade do |t|
    t.integer "worker_id", null: false
    t.string "name_of_beneficiary", null: false
    t.string "account_number", null: false
    t.string "bank_name", null: false
    t.string "ifsc_code", null: false
    t.string "branch_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_bank_details_on_account_number", unique: true
    t.index ["ifsc_code"], name: "index_bank_details_on_ifsc_code"
    t.index ["worker_id"], name: "index_bank_details_on_worker_id", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_updates", force: :cascade do |t|
    t.text "note"
    t.integer "user_id", null: false
    t.boolean "approved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_updates_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "status"
    t.integer "company_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.decimal "customer_budget"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "content"
    t.integer "daily_update_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_update_id"], name: "index_replies_on_daily_update_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.string "unit"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["company_id"], name: "index_stocks_on_company_id"
    t.index ["project_id"], name: "index_stocks_on_project_id"
  end

  create_table "team_heads", force: :cascade do |t|
    t.string "name", null: false
    t.date "dob"
    t.integer "age"
    t.string "gender"
    t.text "address"
    t.string "aadhaar_number"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aadhaar_number"], name: "index_team_heads_on_aadhaar_number", unique: true
    t.index ["contact_number"], name: "index_team_heads_on_contact_number"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "nature_of_skill", default: "local_team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_head_id"
    t.index ["team_head_id"], name: "index_teams_on_team_head_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.integer "project_id", null: false
    t.integer "head_worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nature_of_worker", default: 0
    t.integer "team_id"
    t.string "worker_id", null: false
    t.index ["head_worker_id"], name: "index_workers_on_head_worker_id"
    t.index ["project_id"], name: "index_workers_on_project_id"
    t.index ["team_id"], name: "index_workers_on_team_id"
    t.index ["worker_id"], name: "index_workers_on_worker_id", unique: true
  end

  add_foreign_key "api_accesses", "users"
  add_foreign_key "attendances", "workers"
  add_foreign_key "bank_details", "workers"
  add_foreign_key "daily_updates", "users"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "users"
  add_foreign_key "replies", "daily_updates"
  add_foreign_key "replies", "users"
  add_foreign_key "stocks", "companies"
  add_foreign_key "stocks", "projects"
  add_foreign_key "teams", "team_heads"
  add_foreign_key "workers", "projects"
  add_foreign_key "workers", "teams"
  add_foreign_key "workers", "workers", column: "head_worker_id"
end
