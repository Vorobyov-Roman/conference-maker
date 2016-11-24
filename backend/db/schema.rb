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

ActiveRecord::Schema.define(version: 20161117174011) do

  create_table "applications", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "sender_id"
    t.integer  "topic_id"
    t.index ["sender_id"], name: "index_applications_on_sender_id"
    t.index ["topic_id"], name: "index_applications_on_topic_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
    t.index ["creator_id"], name: "index_conferences_on_creator_id"
  end

  create_table "conferences_organizers", id: false, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "organizer_id",  null: false
    t.index ["organizer_id", "conference_id"], name: "index_conferences_organizers_on_organizer_id_and_conference_id"
  end

  create_table "moderators_topics", id: false, force: :cascade do |t|
    t.integer "topic_id",     null: false
    t.integer "moderator_id", null: false
    t.index ["topic_id", "moderator_id"], name: "index_moderators_topics_on_topic_id_and_moderator_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "status",         default: 0
    t.text     "comment"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "application_id"
    t.integer  "reviewer_id"
    t.index ["application_id"], name: "index_reviews_on_application_id"
    t.index ["reviewer_id", "application_id"], name: "index_reviews_on_reviewer_id_and_application_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "conference_id"
    t.index ["conference_id"], name: "index_topics_on_conference_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
