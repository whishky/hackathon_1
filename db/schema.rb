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

ActiveRecord::Schema.define(version: 20160526111408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avgratings", force: :cascade do |t|
    t.integer  "ratingsum"
    t.integer  "rateduser"
    t.integer  "gallary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "avgratings", ["gallary_id"], name: "index_avgratings_on_gallary_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "comments", ["event_id", "created_at"], name: "index_comments_on_event_id_and_created_at", using: :btree
  add_index "comments", ["event_id"], name: "index_comments_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "address"
    t.string   "event_creater"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "start_date_time"
    t.string   "end_date_time"
    t.integer  "user_id"
  end

  create_table "gallaries", force: :cascade do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  add_index "gallaries", ["event_id"], name: "index_gallaries_on_event_id", using: :btree

  create_table "gallaryratings", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "gallary_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gallaryratings", ["gallary_id"], name: "index_gallaryratings_on_gallary_id", using: :btree
  add_index "gallaryratings", ["user_id"], name: "index_gallaryratings_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["event_id"], name: "index_taggings_on_event_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "avgratings", "gallaries"
  add_foreign_key "comments", "events"
  add_foreign_key "gallaries", "events"
  add_foreign_key "gallaryratings", "gallaries"
  add_foreign_key "gallaryratings", "users"
  add_foreign_key "taggings", "events"
  add_foreign_key "taggings", "tags"
end
