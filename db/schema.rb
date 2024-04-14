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

ActiveRecord::Schema[7.1].define(version: 2024_04_14_121428) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payors", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "instrument_id", null: false
    t.text "description"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_teachers_on_instrument_id"
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

  add_foreign_key "courses", "instruments"
  add_foreign_key "courses", "slots"
  add_foreign_key "slots", "cities"
  add_foreign_key "slots", "teachers"
  add_foreign_key "subscriptions", "courses"
  add_foreign_key "subscriptions", "payors"
  add_foreign_key "subscriptions", "students"
  add_foreign_key "subscriptions", "workshops"
  add_foreign_key "teachers", "instruments"
  add_foreign_key "workshops", "cities"
end
