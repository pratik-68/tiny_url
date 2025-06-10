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

ActiveRecord::Schema[8.0].define(version: 2025_06_10_161114) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clicks", force: :cascade do |t|
    t.bigint "short_url_id", null: false
    t.datetime "clicked_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_url_id", "clicked_at"], name: "index_clicks_on_short_url_id_and_clicked_at"
    t.index ["short_url_id"], name: "index_clicks_on_short_url_id"
  end

  create_table "short_urls", force: :cascade do |t|
    t.text "original_url", null: false
    t.string "short_code", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_url", "is_active"], name: "index_short_urls_on_original_url_and_is_active"
    t.index ["short_code"], name: "index_short_urls_on_short_code", unique: true
  end

  add_foreign_key "clicks", "short_urls"
end
