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

ActiveRecord::Schema[8.0].define(version: 2025_10_14_172610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "municipalities", force: :cascade do |t|
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city", "country"], name: "index_municipalities_on_city_and_country"
    t.index ["postal_code", "country"], name: "index_municipalities_on_postal_code_and_country"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.date "birth_date"
    t.integer "gender"
    t.string "email"
    t.string "phone"
    t.string "mobile_phone"
    t.string "internet"
    t.string "address_line1"
    t.string "address_line2"
    t.bigint "municipality_id", null: false
    t.string "national_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birth_date", "surname"], name: "index_patients_on_birth_date_and_surname"
    t.index ["email"], name: "index_patients_on_email"
    t.index ["municipality_id"], name: "index_patients_on_municipality_id"
    t.index ["national_number"], name: "index_patients_on_national_number"
    t.index ["surname", "first_name"], name: "index_patients_on_surname_and_first_name"
  end

  add_foreign_key "patients", "municipalities"
end
