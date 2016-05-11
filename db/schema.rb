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

ActiveRecord::Schema.define(version: 20160511003438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "box_offices", primary_key: "box_office_id", force: :cascade do |t|
    t.string   "state",              default: "new", null: false
    t.integer  "event_id",                           null: false
    t.datetime "presale_start_time"
    t.datetime "presale_end_time"
    t.datetime "sale_start_time"
    t.datetime "sale_end_time"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "consent_types", primary_key: "consent_type_id", force: :cascade do |t|
    t.text "consent_type", null: false
  end

  add_index "consent_types", ["consent_type"], name: "consent_types__u_consent_type", unique: true, using: :btree

  create_table "consents", primary_key: "consent_id", force: :cascade do |t|
    t.integer  "consent_type_id",  null: false
    t.integer  "ip_address_id",    null: false
    t.integer  "consentable_id",   null: false
    t.string   "consentable_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "consents", ["consentable_type", "consentable_id"], name: "index_consents_on_consentable_type_and_consentable_id", using: :btree

  create_table "espinita_audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "audited_changes"
    t.string   "comment"
    t.integer  "version"
    t.string   "action"
    t.string   "remote_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "espinita_audits", ["auditable_type", "auditable_id"], name: "index_espinita_audits_on_auditable_type_and_auditable_id", using: :btree
  add_index "espinita_audits", ["user_type", "user_id"], name: "index_espinita_audits_on_user_type_and_user_id", using: :btree

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

  create_table "events", primary_key: "event_id", force: :cascade do |t|
    t.string   "name",                            null: false
    t.integer  "organization_id",                 null: false
    t.datetime "start_time",                      null: false
    t.datetime "end_time",                        null: false
    t.string   "state",           default: "new", null: false
    t.text     "description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image"
  end

  create_table "ip_addresses", primary_key: "ip_address_id", force: :cascade do |t|
    t.text "ip_address", null: false
  end

  add_index "ip_addresses", ["ip_address"], name: "ip_addresses__u_ip_address", unique: true, using: :btree

  create_table "memberships", primary_key: "membership_id", force: :cascade do |t|
    t.integer  "organization_id",                 null: false
    t.integer  "user_id",                         null: false
    t.boolean  "ownership",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "organizations", primary_key: "organization_id", force: :cascade do |t|
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

  create_table "regions", primary_key: "region_id", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "last_touched_at"
    t.boolean  "admin",           default: false
  end

  create_table "venues", primary_key: "venue_id", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
