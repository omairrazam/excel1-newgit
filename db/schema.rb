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

ActiveRecord::Schema.define(version: 20161028045751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "adt_data", force: :cascade do |t|
    t.string   "x_values"
    t.integer  "adt_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "timestamp_ms", limit: 8
    t.float    "y1_values"
    t.float    "y2_values"
  end

  add_index "adt_data", ["adt_id"], name: "index_adt_data_on_adt_id", using: :btree

  create_table "adts", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "graph_id"
    t.string   "name"
    t.string   "x_colname"
    t.string   "y_colname"
    t.string   "sheetname"
    t.string   "y_legend"
    t.string   "color_y"
    t.integer  "order_num"
    t.string   "graph_type", default: "line"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "sheetname"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "open_colname"
    t.string   "close_colname"
    t.string   "high_colname"
    t.string   "low_colname"
    t.string   "sp_x_colname"
    t.integer  "order_num"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "commentaries", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "typee"
    t.string   "priceTarget"
  end

  create_table "eod_data", force: :cascade do |t|
    t.string   "txt"
    t.float    "value"
    t.string   "datee"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "category_id"
    t.integer  "order_number"
    t.float    "latest_close"
    t.float    "previous_close"
    t.float    "week_ago"
  end

  add_index "eod_data", ["category_id"], name: "index_eod_data_on_category_id", using: :btree

  create_table "eod_sheets", force: :cascade do |t|
    t.string   "filename"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "category_id"
    t.string   "datee"
  end

  create_table "excelsheets", force: :cascade do |t|
    t.string   "filename"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "general_market_studies", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "category"
    t.string   "slug"
  end

  add_index "general_market_studies", ["slug"], name: "index_general_market_studies_on_slug", unique: true, using: :btree

  create_table "graph_data", force: :cascade do |t|
    t.string   "x_values"
    t.integer  "graph_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "timestamp_ms", limit: 8
    t.float    "y1_values"
    t.float    "y2_values"
  end

  add_index "graph_data", ["graph_id"], name: "index_graph_data_on_graph_id", using: :btree

  create_table "graphs", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.string   "name"
    t.string   "x_colname"
    t.string   "y1_colname"
    t.string   "y2_colname"
    t.string   "sheetname"
    t.string   "y1_legend"
    t.string   "y2_legend"
    t.string   "color_y1"
    t.string   "color_y2"
    t.integer  "order_num"
    t.text     "definition"
    t.string   "period"
  end

  create_table "interactive_charts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interesteds", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_internals", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_studies", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "typee"
    t.string   "price_target"
    t.integer  "user_id"
    t.string   "image"
    t.string   "slug"
  end

  add_index "market_studies", ["slug"], name: "index_market_studies_on_slug", unique: true, using: :btree

  create_table "paypal_packages", force: :cascade do |t|
    t.float    "amount"
    t.integer  "period"
    t.integer  "cycles"
    t.string   "subscription_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string   "code"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sp_graphs", force: :cascade do |t|
    t.float    "open"
    t.float    "high"
    t.float    "low"
    t.float    "close"
    t.integer  "timestamp_ms", limit: 8
    t.integer  "category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "x_values"
  end

  add_index "sp_graphs", ["category_id"], name: "index_sp_graphs_on_category_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.text     "notification"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.string   "transaction_subject"
    t.datetime "payment_date"
    t.string   "txn_type"
    t.string   "subscr_id"
    t.string   "last_name"
    t.string   "residence_country"
    t.string   "item_name"
    t.string   "payment_gross"
    t.string   "mc_currency"
    t.string   "business"
    t.string   "payment_type"
    t.string   "protection_eligibility"
    t.string   "verify_sign"
    t.string   "payer_status"
    t.string   "test_ipn"
    t.string   "payer_email"
    t.string   "txn_id"
    t.string   "receiver_email"
    t.string   "first_name"
    t.string   "invoice"
    t.string   "payer_id"
    t.string   "receiver_id"
    t.string   "payment_status"
    t.string   "payment_fee"
    t.string   "mc_fee"
    t.string   "mc_gross"
    t.string   "charset"
    t.string   "notify_version"
    t.string   "ipn_track_id"
    t.string   "auth"
    t.string   "mc_amount3"
    t.string   "period3"
    t.string   "subscr_date"
    t.string   "recur_times"
    t.string   "reattempt"
    t.integer  "recurring"
    t.string   "amount3"
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "account_active",         default: false
    t.boolean  "is_admin",               default: false
    t.boolean  "recurring",              default: true
    t.string   "period",                 default: "Month"
    t.integer  "cycles",                 default: 12
    t.string   "username"
    t.boolean  "agreed"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "eod_data", "categories"
end
