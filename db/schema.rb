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

ActiveRecord::Schema[7.0].define(version: 2022_08_22_074645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.string "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_members_on_event_id"
    t.index ["user_id"], name: "index_event_members_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.string "name"
    t.string "event_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "event_member_id", null: false
    t.string "room_type", null: false
    t.bigint "room_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_member_id"], name: "index_messages_on_event_member_id"
    t.index ["room_type", "room_id"], name: "index_messages_on_room"
  end

  create_table "task_members", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "event_member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_member_id"], name: "index_task_members_on_event_member_id"
    t.index ["task_id"], name: "index_task_members_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.string "description"
    t.string "status"
    t.date "start"
    t.date "end"
    t.string "category"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tasks_on_event_id"
    t.index ["task_id"], name: "index_tasks_on_task_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "phone_number"
    t.string "line_id"
    t.string "location"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_members", "events"
  add_foreign_key "event_members", "users"
  add_foreign_key "messages", "event_members"
  add_foreign_key "task_members", "event_members"
  add_foreign_key "task_members", "tasks"
  add_foreign_key "tasks", "events"
  add_foreign_key "tasks", "tasks"
end
