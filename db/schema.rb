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

ActiveRecord::Schema.define(version: 20160207201202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "event_id",                   null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "event_transitions", ["event_id", "most_recent"], name: "index_event_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "event_transitions", ["event_id", "sort_key"], name: "index_event_transitions_parent_sort", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",                            null: false
    t.integer  "organization_id",                 null: false
    t.datetime "start_time",                      null: false
    t.datetime "end_time",                        null: false
    t.string   "state",           default: "new", null: false
    t.text     "description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "organization_id",                 null: false
    t.integer  "user_id",                         null: false
    t.boolean  "ownership",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_venues", id: false, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "venue_id"
  end

  add_index "organizations_venues", ["organization_id"], name: "index_organizations_venues_on_organization_id", using: :btree
  add_index "organizations_venues", ["venue_id"], name: "index_organizations_venues_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
