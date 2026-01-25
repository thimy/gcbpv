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

ActiveRecord::Schema[8.1].define(version: 2026_02_04_142312) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agglomerations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "attachable_id"
    t.string "attachable_type"
    t.datetime "created_at", null: false
    t.string "extension"
    t.string "name"
    t.float "size"
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable"
  end

  create_table "bogues", force: :cascade do |t|
    t.text "comment"
    t.jsonb "content"
    t.datetime "created_at", null: false
    t.datetime "end_date"
    t.string "name"
    t.string "slug"
    t.datetime "start_date"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "cover1"
    t.string "cover2"
    t.string "cover3"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "categories_posts", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "post_id"
    t.index ["category_id"], name: "index_categories_posts_on_category_id"
    t.index ["post_id"], name: "index_categories_posts_on_post_id"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "agglomeration_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "postcode"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["agglomeration_id"], name: "index_cities_on_agglomeration_id"
  end

  create_table "configs", force: :cascade do |t|
    t.text "banner"
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_configs_on_season_id"
  end

  create_table "courses", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.time "end_time"
    t.integer "frequency"
    t.bigint "instrument_id", null: false
    t.integer "option"
    t.bigint "slot_id", null: false
    t.time "start_time"
    t.bigint "subscription_id"
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_courses_on_instrument_id"
    t.index ["slot_id"], name: "index_courses_on_slot_id"
    t.index ["subscription_id"], name: "index_courses_on_subscription_id"
  end

  create_table "editions", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "format"
    t.string "image"
    t.string "name"
    t.decimal "price"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "email_images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "email_id"
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_email_images_on_email_id"
  end

  create_table "emails", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "recipients"
    t.integer "status"
    t.string "subject"
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "bogue_id"
    t.string "city"
    t.text "comment"
    t.jsonb "content"
    t.string "cover"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "end_date"
    t.time "end_time"
    t.integer "event_type"
    t.boolean "highlight"
    t.boolean "is_emt"
    t.text "location"
    t.string "name"
    t.string "organizer"
    t.bigint "parent_event_id"
    t.string "slug"
    t.datetime "start_date"
    t.time "start_time"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.string "website"
    t.index ["bogue_id"], name: "index_events_on_bogue_id"
    t.index ["parent_event_id"], name: "index_events_on_parent_event_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "households", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "postcode"
    t.string "secondary_email"
    t.string "secondary_first_name"
    t.string "secondary_last_name"
    t.string "secondary_phone"
    t.datetime "updated_at", null: false
  end

  create_table "instrument_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "instrument_id", null: false
    t.bigint "season_id", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_instrument_seasons_on_instrument_id"
    t.index ["season_id"], name: "index_instrument_seasons_on_season_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.text "comment"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.string "instrument"
    t.bigint "subscription_id", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_loans_on_subscription_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "bogue_id"
    t.string "city"
    t.text "comment"
    t.jsonb "content"
    t.datetime "created_at", null: false
    t.datetime "end_date"
    t.string "location"
    t.string "name"
    t.string "slug"
    t.datetime "start_date"
    t.integer "status"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["bogue_id"], name: "index_pages_on_bogue_id"
  end

  create_table "pathway_slot_teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "pathway_slot_id"
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pathway_slot_id"], name: "index_pathway_slot_teachers_on_pathway_slot_id"
    t.index ["teacher_id"], name: "index_pathway_slot_teachers_on_teacher_id"
  end

  create_table "pathway_slots", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "day_of_week"
    t.bigint "pathway_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_pathway_slots_on_city_id"
    t.index ["pathway_id"], name: "index_pathway_slots_on_pathway_id"
  end

  create_table "pathways", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "date"
    t.integer "payment_method"
    t.bigint "subscription_group_id", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_group_id"], name: "index_payments_on_subscription_group_id"
  end

  create_table "plan_price_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "obc_price"
    t.decimal "outbounds_price"
    t.bigint "plan_id", null: false
    t.decimal "price"
    t.bigint "price_category_id", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_price_categories_on_plan_id"
    t.index ["price_category_id"], name: "index_plan_price_categories_on_price_category_id"
  end

  create_table "plans", force: :cascade do |t|
    t.decimal "class_price"
    t.decimal "class_price_obc"
    t.decimal "class_price_outbounds"
    t.text "comment"
    t.datetime "created_at", null: false
    t.decimal "early_learning_price"
    t.decimal "early_learning_price_obc"
    t.decimal "early_learning_price_outbounds"
    t.decimal "first_step"
    t.decimal "first_step_discount"
    t.decimal "kid_discovery_price"
    t.decimal "kid_discovery_price_obc"
    t.decimal "kid_discovery_price_outbounds"
    t.decimal "kids_class_price"
    t.decimal "kids_class_price_obc"
    t.decimal "kids_class_price_outbounds"
    t.integer "membership_price"
    t.string "name"
    t.integer "obc_markup"
    t.integer "outbounds_markup"
    t.decimal "second_step"
    t.decimal "second_step_discount"
    t.decimal "third_step"
    t.decimal "third_step_discount"
    t.datetime "updated_at", null: false
    t.decimal "workshop_price"
    t.decimal "workshop_price_obc"
    t.decimal "workshop_price_outbounds"
  end

  create_table "posts", force: :cascade do |t|
    t.jsonb "content"
    t.string "cover"
    t.datetime "created_at", null: false
    t.bigint "event_id"
    t.datetime "published_at"
    t.datetime "sent_at"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_posts_on_event_id"
  end

  create_table "price_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "project_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id"
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_students_on_project_id"
    t.index ["student_id"], name: "index_project_students_on_student_id"
  end

  create_table "projects", force: :cascade do |t|
    t.text "comment"
    t.text "content"
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "season_id"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_projects_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "plan_id", null: false
    t.integer "start_year"
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_seasons_on_plan_id"
  end

  create_table "slot_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.bigint "slot_id", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_slot_seasons_on_season_id"
    t.index ["slot_id"], name: "index_slot_seasons_on_slot_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "day_of_week"
    t.integer "frequency"
    t.string "slot_time"
    t.integer "status"
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_slots_on_city_id"
    t.index ["teacher_id"], name: "index_slots_on_teacher_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "instrument_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_specialties_on_instrument_id"
    t.index ["teacher_id"], name: "index_specialties_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "address"
    t.integer "birth_year"
    t.string "city"
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.integer "gender"
    t.string "last_name"
    t.string "phone"
    t.string "postcode"
    t.datetime "updated_at", null: false
  end

  create_table "subbed_pathways", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.bigint "pathway_slot_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pathway_slot_id"], name: "index_subbed_pathways_on_pathway_slot_id"
    t.index ["subscription_id"], name: "index_subbed_pathways_on_subscription_id"
  end

  create_table "subbed_workshops", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "option"
    t.bigint "subscription_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "workshop_slot_id"
    t.index ["subscription_id"], name: "index_subbed_workshops_on_subscription_id"
    t.index ["workshop_slot_id"], name: "index_subbed_workshops_on_workshop_slot_id"
  end

  create_table "subscription_groups", force: :cascade do |t|
    t.decimal "amount"
    t.decimal "amount_paid"
    t.text "comment"
    t.datetime "created_at", null: false
    t.decimal "discount"
    t.decimal "donation"
    t.bigint "household_id"
    t.integer "majoration_class"
    t.bigint "season_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_subscription_groups_on_household_id"
    t.index ["season_id"], name: "index_subscription_groups_on_season_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.boolean "ars"
    t.text "comment"
    t.datetime "created_at", null: false
    t.boolean "disability"
    t.boolean "image_consent"
    t.string "instrument_loan"
    t.integer "status"
    t.bigint "student_id", null: false
    t.bigint "subscription_group_id"
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_subscriptions_on_student_id"
    t.index ["subscription_group_id"], name: "index_subscriptions_on_subscription_group_id"
  end

  create_table "teacher_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_teacher_seasons_on_season_id"
    t.index ["teacher_id"], name: "index_teacher_seasons_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "photo"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "teachers_workshops", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "workshop_id"
    t.index ["teacher_id"], name: "index_teachers_workshops_on_teacher_id"
    t.index ["workshop_id"], name: "index_teachers_workshops_on_workshop_id"
  end

  create_table "thredded_categories", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "messageboard_id", null: false
    t.text "name", null: false
    t.text "slug", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index "lower(name) text_pattern_ops", name: "thredded_categories_name_ci"
    t.index ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true
    t.index ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id"
  end

  create_table "thredded_messageboard_groups", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.integer "position", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "thredded_messageboard_notifications_for_followed_topics", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.bigint "messageboard_id", null: false
    t.string "notifier_key", limit: 90, null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "messageboard_id", "notifier_key"], name: "thredded_messageboard_notifications_for_followed_topics_unique", unique: true
  end

  create_table "thredded_messageboard_users", force: :cascade do |t|
    t.datetime "last_seen_at", precision: nil, null: false
    t.bigint "thredded_messageboard_id", null: false
    t.bigint "thredded_user_detail_id", null: false
    t.index ["thredded_messageboard_id", "last_seen_at"], name: "index_thredded_messageboard_users_for_recently_active"
    t.index ["thredded_messageboard_id", "thredded_user_detail_id"], name: "index_thredded_messageboard_users_primary", unique: true
  end

  create_table "thredded_messageboards", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "last_topic_id"
    t.boolean "locked", default: false, null: false
    t.bigint "messageboard_group_id"
    t.text "name", null: false
    t.integer "position", null: false
    t.integer "posts_count", default: 0
    t.text "slug"
    t.integer "topics_count", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["messageboard_group_id"], name: "index_thredded_messageboards_on_messageboard_group_id"
    t.index ["slug"], name: "index_thredded_messageboards_on_slug", unique: true
  end

  create_table "thredded_notifications_for_followed_topics", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "notifier_key", limit: 90, null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "notifier_key"], name: "thredded_notifications_for_followed_topics_unique", unique: true
  end

  create_table "thredded_notifications_for_private_topics", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "notifier_key", limit: 90, null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "notifier_key"], name: "thredded_notifications_for_private_topics_unique", unique: true
  end

  create_table "thredded_post_moderation_records", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "messageboard_id"
    t.integer "moderation_state", null: false
    t.bigint "moderator_id"
    t.text "post_content"
    t.bigint "post_id"
    t.bigint "post_user_id"
    t.text "post_user_name"
    t.integer "previous_moderation_state", null: false
    t.index ["messageboard_id", "created_at"], name: "index_thredded_moderation_records_for_display", order: { created_at: :desc }
  end

  create_table "thredded_posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "messageboard_id", null: false
    t.integer "moderation_state", null: false
    t.bigint "postable_id", null: false
    t.string "source", limit: 191, default: "web"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index "to_tsvector('english'::regconfig, content)", name: "thredded_posts_content_fts", using: :gist
    t.index ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id"
    t.index ["moderation_state", "updated_at"], name: "index_thredded_posts_for_display"
    t.index ["postable_id", "created_at"], name: "index_thredded_posts_on_postable_id_and_created_at"
    t.index ["postable_id"], name: "index_thredded_posts_on_postable_id"
    t.index ["user_id"], name: "index_thredded_posts_on_user_id"
  end

  create_table "thredded_private_posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "postable_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["postable_id", "created_at"], name: "index_thredded_private_posts_on_postable_id_and_created_at"
  end

  create_table "thredded_private_topics", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "hash_id", limit: 20, null: false
    t.datetime "last_post_at", precision: nil
    t.bigint "last_user_id"
    t.integer "posts_count", default: 0
    t.text "slug", null: false
    t.text "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["hash_id"], name: "index_thredded_private_topics_on_hash_id"
    t.index ["last_post_at"], name: "index_thredded_private_topics_on_last_post_at"
    t.index ["slug"], name: "index_thredded_private_topics_on_slug", unique: true
  end

  create_table "thredded_private_users", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "private_topic_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id"
    t.index ["user_id"], name: "index_thredded_private_users_on_user_id"
  end

  create_table "thredded_topic_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "topic_id", null: false
    t.index ["category_id"], name: "index_thredded_topic_categories_on_category_id"
    t.index ["topic_id"], name: "index_thredded_topic_categories_on_topic_id"
  end

  create_table "thredded_topics", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "hash_id", limit: 20, null: false
    t.datetime "last_post_at", precision: nil
    t.bigint "last_user_id"
    t.boolean "locked", default: false, null: false
    t.bigint "messageboard_id", null: false
    t.integer "moderation_state", null: false
    t.integer "posts_count", default: 0, null: false
    t.text "slug", null: false
    t.boolean "sticky", default: false, null: false
    t.text "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index "to_tsvector('english'::regconfig, title)", name: "thredded_topics_title_fts", using: :gist
    t.index ["hash_id"], name: "index_thredded_topics_on_hash_id"
    t.index ["last_post_at"], name: "index_thredded_topics_on_last_post_at"
    t.index ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id"
    t.index ["moderation_state", "sticky", "updated_at"], name: "index_thredded_topics_for_display", order: { sticky: :desc, updated_at: :desc }
    t.index ["slug"], name: "index_thredded_topics_on_slug", unique: true
    t.index ["user_id"], name: "index_thredded_topics_on_user_id"
  end

  create_table "thredded_user_details", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "last_seen_at", precision: nil
    t.datetime "latest_activity_at", precision: nil
    t.integer "moderation_state", default: 0, null: false
    t.datetime "moderation_state_changed_at", precision: nil
    t.integer "posts_count", default: 0
    t.integer "topics_count", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.index ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at"
    t.index ["moderation_state", "moderation_state_changed_at"], name: "index_thredded_user_details_for_moderations", order: { moderation_state_changed_at: :desc }
    t.index ["user_id"], name: "index_thredded_user_details_on_user_id", unique: true
  end

  create_table "thredded_user_messageboard_preferences", force: :cascade do |t|
    t.boolean "auto_follow_topics", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "follow_topics_on_mention", default: true, null: false
    t.bigint "messageboard_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "messageboard_id"], name: "thredded_user_messageboard_preferences_user_id_messageboard_id", unique: true
  end

  create_table "thredded_user_post_notifications", force: :cascade do |t|
    t.datetime "notified_at", precision: nil, null: false
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_thredded_user_post_notifications_on_post_id"
    t.index ["user_id", "post_id"], name: "index_thredded_user_post_notifications_on_user_id_and_post_id", unique: true
  end

  create_table "thredded_user_preferences", force: :cascade do |t|
    t.boolean "auto_follow_topics", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "follow_topics_on_mention", default: true, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_thredded_user_preferences_on_user_id", unique: true
  end

  create_table "thredded_user_private_topic_read_states", force: :cascade do |t|
    t.integer "integer", default: 0, null: false
    t.bigint "postable_id", null: false
    t.datetime "read_at", precision: nil, null: false
    t.integer "read_posts_count", default: 0, null: false
    t.integer "unread_posts_count", default: 0, null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "postable_id"], name: "thredded_user_private_topic_read_states_user_postable", unique: true
  end

  create_table "thredded_user_topic_follows", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "reason", limit: 2
    t.bigint "topic_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "topic_id"], name: "thredded_user_topic_follows_user_topic", unique: true
  end

  create_table "thredded_user_topic_read_states", force: :cascade do |t|
    t.integer "integer", default: 0, null: false
    t.bigint "messageboard_id", null: false
    t.bigint "postable_id", null: false
    t.datetime "read_at", precision: nil, null: false
    t.integer "read_posts_count", default: 0, null: false
    t.integer "unread_posts_count", default: 0, null: false
    t.bigint "user_id", null: false
    t.index ["messageboard_id"], name: "index_thredded_user_topic_read_states_on_messageboard_id"
    t.index ["user_id", "messageboard_id"], name: "thredded_user_topic_read_states_user_messageboard"
    t.index ["user_id", "postable_id"], name: "thredded_user_topic_read_states_user_postable", unique: true
  end

  create_table "training_sessions", force: :cascade do |t|
    t.string "city"
    t.text "comment"
    t.text "content"
    t.datetime "created_at", null: false
    t.date "date"
    t.string "end_time"
    t.string "guest"
    t.text "image"
    t.string "location"
    t.string "name"
    t.string "start_time"
    t.integer "status"
    t.bigint "training_id", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_training_sessions_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.text "comment"
    t.text "content"
    t.datetime "created_at", null: false
    t.string "name"
    t.decimal "price"
    t.bigint "season_id", null: false
    t.integer "session_count"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_trainings_on_season_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "household_id"
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.bigint "student_id"
    t.bigint "teacher_id"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["student_id"], name: "index_users_on_student_id"
    t.index ["teacher_id"], name: "index_users_on_teacher_id"
  end

  create_table "workshop_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "workshop_id", null: false
    t.index ["season_id"], name: "index_workshop_seasons_on_season_id"
    t.index ["workshop_id"], name: "index_workshop_seasons_on_workshop_id"
  end

  create_table "workshop_slot_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "workshop_slot_id", null: false
    t.index ["season_id"], name: "index_workshop_slot_seasons_on_season_id"
    t.index ["workshop_slot_id"], name: "index_workshop_slot_seasons_on_workshop_slot_id"
  end

  create_table "workshop_slot_teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "workshop_slot_id", null: false
    t.index ["teacher_id"], name: "index_workshop_slot_teachers_on_teacher_id"
    t.index ["workshop_slot_id"], name: "index_workshop_slot_teachers_on_workshop_slot_id"
  end

  create_table "workshop_slots", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "day_of_week"
    t.integer "frequency"
    t.boolean "is_custom"
    t.string "slot_time"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.bigint "workshop_id", null: false
    t.index ["city_id"], name: "index_workshop_slots_on_city_id"
    t.index ["workshop_id"], name: "index_workshop_slots_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "is_full"
    t.boolean "is_youth"
    t.boolean "kid_friendly"
    t.integer "kid_workshop_type"
    t.integer "max_students"
    t.string "name"
    t.bigint "price_category_id"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["price_category_id"], name: "index_workshops_on_price_category_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "configs", "seasons"
  add_foreign_key "courses", "instruments"
  add_foreign_key "courses", "slots"
  add_foreign_key "email_images", "emails"
  add_foreign_key "instrument_seasons", "instruments"
  add_foreign_key "instrument_seasons", "seasons"
  add_foreign_key "loans", "subscriptions"
  add_foreign_key "pathway_slot_teachers", "teachers"
  add_foreign_key "pathway_slots", "cities"
  add_foreign_key "pathway_slots", "pathways"
  add_foreign_key "payments", "subscription_groups"
  add_foreign_key "plan_price_categories", "plans"
  add_foreign_key "plan_price_categories", "price_categories"
  add_foreign_key "project_students", "students"
  add_foreign_key "seasons", "plans"
  add_foreign_key "slot_seasons", "seasons"
  add_foreign_key "slot_seasons", "slots"
  add_foreign_key "slots", "cities"
  add_foreign_key "slots", "teachers"
  add_foreign_key "specialties", "instruments"
  add_foreign_key "specialties", "teachers"
  add_foreign_key "subbed_pathways", "pathway_slots"
  add_foreign_key "subbed_pathways", "subscriptions"
  add_foreign_key "subbed_workshops", "subscriptions"
  add_foreign_key "subscription_groups", "seasons"
  add_foreign_key "subscriptions", "students"
  add_foreign_key "teacher_seasons", "seasons"
  add_foreign_key "teacher_seasons", "teachers"
  add_foreign_key "thredded_messageboard_users", "thredded_messageboards", on_delete: :cascade
  add_foreign_key "thredded_messageboard_users", "thredded_user_details", on_delete: :cascade
  add_foreign_key "thredded_user_post_notifications", "thredded_posts", column: "post_id", on_delete: :cascade
  add_foreign_key "thredded_user_post_notifications", "users", on_delete: :cascade
  add_foreign_key "training_sessions", "trainings"
  add_foreign_key "trainings", "seasons"
  add_foreign_key "workshop_seasons", "seasons"
  add_foreign_key "workshop_seasons", "workshops"
  add_foreign_key "workshop_slot_seasons", "seasons"
  add_foreign_key "workshop_slot_seasons", "workshop_slots"
  add_foreign_key "workshop_slot_teachers", "teachers"
  add_foreign_key "workshop_slot_teachers", "workshop_slots"
  add_foreign_key "workshop_slots", "cities"
  add_foreign_key "workshop_slots", "workshops"
end
