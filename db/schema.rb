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

ActiveRecord::Schema[7.1].define(version: 2024_05_09_132315) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_posts", force: :cascade do |t|
    t.bigint "categories_id"
    t.bigint "posts_id"
    t.index ["categories_id"], name: "index_categories_posts_on_categories_id"
    t.index ["posts_id"], name: "index_categories_posts_on_posts_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configurations", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_configurations_on_season_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "slot_id", null: false
    t.bigint "instrument_id", null: false
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_courses_on_instrument_id"
    t.index ["slot_id"], name: "index_courses_on_slot_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "organizer"
    t.string "website"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "payors", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.decimal "class_price"
    t.decimal "kids_class_price"
    t.decimal "workshop_price"
    t.integer "obc_markup"
    t.integer "outbounds_markup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "image"
    t.string "status"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_posts_on_event_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "start_year"
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_seasons_on_plan_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "city_id", null: false
    t.integer "day_of_week"
    t.string "start_time"
    t.string "end_time"
    t.integer "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_slots_on_city_id"
    t.index ["teacher_id"], name: "index_slots_on_teacher_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_specialties_on_instrument_id"
    t.index ["teacher_id"], name: "index_specialties_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payor_id"
    t.string "street"
    t.string "zip_code"
    t.string "city"
    t.integer "birth_year"
    t.index ["payor_id"], name: "index_students_on_payor_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "year"
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.bigint "workshop_id", null: false
    t.integer "paid_amount"
    t.bigint "payor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_subscriptions_on_course_id"
    t.index ["payor_id"], name: "index_subscriptions_on_payor_id"
    t.index ["student_id"], name: "index_subscriptions_on_student_id"
    t.index ["workshop_id"], name: "index_subscriptions_on_workshop_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.text "description"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workshops", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "city_id", null: false
    t.integer "day_of_week"
    t.integer "frequency"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_workshops_on_city_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "configurations", "seasons"
  add_foreign_key "courses", "instruments"
  add_foreign_key "courses", "slots"
  add_foreign_key "posts", "events"
  add_foreign_key "seasons", "plans"
  add_foreign_key "slots", "cities"
  add_foreign_key "slots", "teachers"
  add_foreign_key "specialties", "instruments"
  add_foreign_key "specialties", "teachers"
  add_foreign_key "subscriptions", "courses"
  add_foreign_key "subscriptions", "payors"
  add_foreign_key "subscriptions", "students"
  add_foreign_key "subscriptions", "workshops"
  add_foreign_key "workshops", "cities"
end
