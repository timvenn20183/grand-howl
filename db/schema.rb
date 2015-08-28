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

ActiveRecord::Schema.define(version: 20150322075215) do

  create_table "advancements", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "slug",         limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "description",  limit: 16777215
    t.integer  "challenge_id", limit: 4
    t.integer  "advlevel_id",  limit: 4
    t.string   "app_name",     limit: 255
  end

  create_table "advlevels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "image",        limit: 255
    t.string   "slug",         limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "requirements", limit: 16777215
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.string   "options",    limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "image",      limit: 255
    t.boolean  "special",    limit: 1,   default: false
  end

  create_table "cattypes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "message",    limit: 65535
    t.string   "subject",    limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "entry_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "venue_id",   limit: 4
    t.integer  "program_id", limit: 4
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "entry_id",       limit: 4
    t.integer  "advancement_id", limit: 4
    t.integer  "category_id",    limit: 4
    t.integer  "badge_id",       limit: 4
    t.string   "raw",            limit: 255
    t.string   "description",    limit: 255
    t.integer  "program_id",     limit: 4
  end

  create_table "entries", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "slug",           limit: 255
    t.integer  "category_id",    limit: 4
    t.text     "description",    limit: 16777215
    t.text     "outcome",        limit: 16777215
    t.text     "instructions",   limit: 16777215
    t.text     "other",          limit: 16777215
    t.text     "resources",      limit: 16777215
    t.text     "story",          limit: 16777215
    t.text     "song",           limit: 16777215
    t.text     "play",           limit: 16777215
    t.integer  "user_id",        limit: 4
    t.integer  "cattype_id",     limit: 4
    t.integer  "badge_id",       limit: 4
    t.integer  "advancement_id", limit: 4
    t.integer  "time",           limit: 4
    t.string   "options",        limit: 255
    t.text     "searchtext",     limit: 16777215
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "views",          limit: 4,        default: 0
    t.string   "raw",            limit: 255
    t.boolean  "isdefault",      limit: 1,        default: false
  end

  create_table "entries_programs", id: false, force: :cascade do |t|
    t.integer "entry_id",   limit: 4
    t.integer "program_id", limit: 4
  end

  add_index "entries_programs", ["entry_id", "program_id"], name: "entries_programs_index", unique: true, using: :btree

  create_table "eventscouters", force: :cascade do |t|
    t.integer  "entry_id",   limit: 4
    t.integer  "program_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "scouter_id", limit: 4
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "lsentences", force: :cascade do |t|
    t.integer  "entry_id",   limit: 4
    t.integer  "program_id", limit: 4
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "programs", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name",       limit: 255
    t.string   "theme",      limit: 255
    t.string   "duty_six",   limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "venue_id",   limit: 4
    t.string   "slug",       limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "runtime",    limit: 4
    t.string   "image",      limit: 255
    t.boolean  "shared",     limit: 1,     default: false
    t.integer  "views",      limit: 4
    t.text     "entryorder", limit: 65535
    t.text     "entrytime",  limit: 65535
    t.boolean  "viewlinked", limit: 1,     default: true
    t.text     "daybreaks",  limit: 65535
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "rating",     limit: 4
    t.integer  "entry_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "scouters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "email",         limit: 255
    t.string   "pass",          limit: 255
    t.boolean  "active",        limit: 1,     default: true
    t.integer  "level",         limit: 4,     default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "activation",    limit: 255
    t.string   "group",         limit: 255
    t.text     "options",       limit: 65535
    t.integer  "venue_id",      limit: 4
    t.string   "program_color", limit: 255
    t.integer  "program_day",   limit: 4
    t.datetime "program_time"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "slug",           limit: 255
    t.boolean  "is_camp",        limit: 1
    t.boolean  "is_day",         limit: 1
    t.text     "description",    limit: 16777215
    t.text     "activities",     limit: 16777215
    t.text     "pros",           limit: 16777215
    t.text     "cons",           limit: 16777215
    t.integer  "user_id",        limit: 4
    t.string   "image",          limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "searchtext",     limit: 16777215
    t.integer  "province_id",    limit: 4
    t.string   "area",           limit: 255
    t.integer  "time_from_city", limit: 4
    t.string   "website",        limit: 255
    t.integer  "views",          limit: 4
    t.string   "tel",            limit: 255
  end

end
