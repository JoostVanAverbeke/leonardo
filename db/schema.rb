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

ActiveRecord::Schema[8.0].define(version: 2025_11_01_143032) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "hc_providers", force: :cascade do |t|
    t.string "mnemonic"
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
    t.string "identifier"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birth_date", "surname"], name: "index_hc_providers_on_birth_date_and_surname"
    t.index ["email"], name: "index_hc_providers_on_email"
    t.index ["identifier"], name: "index_hc_providers_on_identifier"
    t.index ["mnemonic"], name: "index_hc_providers_on_mnemonic", unique: true
    t.index ["municipality_id"], name: "index_hc_providers_on_municipality_id"
    t.index ["surname", "first_name"], name: "index_hc_providers_on_surname_and_first_name"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city", "country"], name: "index_municipalities_on_city_and_country"
    t.index ["postal_code", "country"], name: "index_municipalities_on_postal_code_and_country"
  end

  create_table "observations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "order_id", null: false
    t.bigint "property_id", null: false
    t.string "value"
    t.string "unit"
    t.string "alternate_unit"
    t.string "alternate_unit_coding_system"
    t.string "references_range"
    t.string "abnormal_flags"
    t.integer "result_status"
    t.datetime "observation_date_time"
    t.datetime "analysis_date_time"
    t.text "observation_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_observations_on_order_id"
    t.index ["patient_id", "observation_date_time", "property_id", "analysis_date_time"], name: "index_observations_on_patient_obsdate_property_analysisdate", order: { observation_date_time: :desc, analysis_date_time: :desc }
    t.index ["patient_id", "property_id", "observation_date_time", "analysis_date_time"], name: "index_observations_on_patient_property_obsdate_analysisdate", order: { observation_date_time: :desc, analysis_date_time: :desc }
    t.index ["patient_id"], name: "index_observations_on_patient_id"
    t.index ["property_id", "analysis_date_time"], name: "index_observations_on_property_analysisdate", order: { analysis_date_time: :desc }
    t.index ["property_id", "observation_date_time"], name: "index_observations_on_property_obsdate", order: { observation_date_time: :desc }
    t.index ["property_id"], name: "index_observations_on_property_id"
    t.index ["result_status"], name: "index_observations_on_result_status"
  end

  create_table "orders", force: :cascade do |t|
    t.string "placer_order_number"
    t.string "filler_order_number"
    t.integer "priority"
    t.integer "order_status"
    t.bigint "patient_id", null: false
    t.bigint "ordering_provider_id", null: false
    t.text "relevant_clinical_information"
    t.string "order_call_back_phone"
    t.datetime "receipt_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filler_order_number"], name: "index_orders_on_filler_order_number", unique: true
    t.index ["ordering_provider_id", "receipt_time"], name: "index_orders_on_ordering_provider_id_and_receipt_time_desc", order: { receipt_time: :desc }
    t.index ["ordering_provider_id"], name: "index_orders_on_ordering_provider_id"
    t.index ["patient_id", "receipt_time"], name: "index_orders_on_patient_id_and_receipt_time_desc", order: { receipt_time: :desc }
    t.index ["patient_id"], name: "index_orders_on_patient_id"
    t.index ["receipt_time"], name: "index_orders_on_receipt_time_desc", order: :desc
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

  create_table "properties", force: :cascade do |t|
    t.string "mnemonic"
    t.string "loinc_code"
    t.string "units_of_measure"
    t.decimal "low_limit"
    t.decimal "high_limit"
    t.integer "data_type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loinc_code"], name: "index_properties_on_loinc_code", unique: true
    t.index ["mnemonic"], name: "index_properties_on_mnemonic", unique: true
  end

  add_foreign_key "hc_providers", "municipalities"
  add_foreign_key "observations", "orders"
  add_foreign_key "observations", "patients"
  add_foreign_key "observations", "properties"
  add_foreign_key "orders", "hc_providers", column: "ordering_provider_id"
  add_foreign_key "orders", "patients"
  add_foreign_key "patients", "municipalities"
end
