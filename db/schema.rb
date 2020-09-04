# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_03_075053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.index ["user_id", "name"], name: "index_labels_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "task_labels", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "task_id", null: false
    t.bigint "label_id", null: false
    t.index ["label_id"], name: "index_task_labels_on_label_id"
    t.index ["task_id", "label_id"], name: "index_task_labels_on_task_id_and_label_id", unique: true
    t.index ["task_id"], name: "index_task_labels_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.text "description"
    t.date "end_date"
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.bigint "user_id", null: false
    t.index ["created_at"], name: "index_tasks_on_created_at"
    t.index ["end_date", "created_at"], name: "index_tasks_on_end_date_asc_and_created_at_desc", order: { created_at: :desc }
    t.index ["end_date", "created_at"], name: "index_tasks_on_end_date_desc_and_created_at_desc", order: :desc
    t.index ["end_date"], name: "index_tasks_on_end_date"
    t.index ["priority", "created_at"], name: "index_tasks_on_priority_asc_and_created_at_desc", order: { created_at: :desc }
    t.index ["priority", "created_at"], name: "index_tasks_on_priority_desc_and_created_at_desc", order: :desc
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "labels", "users"
  add_foreign_key "task_labels", "labels"
  add_foreign_key "task_labels", "tasks"
  add_foreign_key "tasks", "users"
end
