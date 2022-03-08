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

ActiveRecord::Schema.define(version: 2022_03_08_131408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agreements", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.date "signed_date"
    t.float "amount"
    t.string "agreement_number"
    t.bigint "user_id", null: false
    t.integer "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "step"
    t.jsonb "diagnosis"
    t.string "aasm_state"
    t.datetime "deleted_at"
    t.string "insurance_period"
    t.index ["agreement_number"], name: "index_agreements_on_agreement_number"
    t.index ["customer_id"], name: "index_agreements_on_customer_id"
    t.index ["deleted_at"], name: "index_agreements_on_deleted_at"
    t.index ["user_id"], name: "index_agreements_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "description"
    t.integer "fileable_id"
    t.string "fileable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "rif"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coverage_items", force: :cascade do |t|
    t.string "title"
    t.jsonb "scale_items", default: []
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coverage_items_plans", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "coverage_item_id", null: false
    t.integer "waiting_period"
    t.integer "coverage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coverage_item_id"], name: "index_coverage_items_plans_on_coverage_item_id"
    t.index ["plan_id"], name: "index_coverage_items_plans_on_plan_id"
  end

  create_table "customer_diseases", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "disease_id", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_customer_diseases_on_customer_id"
    t.index ["disease_id"], name: "index_customer_diseases_on_disease_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "firstname"
    t.string "second_name"
    t.string "last_name"
    t.string "dni"
    t.date "birthday"
    t.string "legal_representative"
    t.jsonb "address"
    t.string "phone"
    t.string "secondary_phone"
    t.string "email"
    t.string "activity"
    t.boolean "main"
    t.float "age"
    t.integer "sex"
    t.string "size"
    t.bigint "parent_id"
    t.bigint "plan_id"
    t.float "coverage_reference"
    t.float "coverage"
    t.boolean "is_insured"
    t.string "customer_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "weight"
    t.datetime "deleted_at"
    t.float "payment_fee"
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
    t.index ["dni"], name: "index_customers_on_dni"
    t.index ["email"], name: "index_customers_on_email"
    t.index ["parent_id"], name: "index_customers_on_parent_id"
    t.index ["plan_id"], name: "index_customers_on_plan_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "title"
    t.boolean "has_description"
    t.jsonb "list_diases", default: []
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventualities", force: :cascade do |t|
    t.string "observations"
    t.integer "event_type"
    t.string "aasm_state"
    t.string "password"
    t.float "amount"
    t.bigint "agreement_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.text "assessment"
    t.string "indications"
    t.string "recipe"
    t.index ["agreement_id"], name: "index_eventualities_on_agreement_id"
    t.index ["customer_id"], name: "index_eventualities_on_customer_id"
  end

  create_table "eventuality_expense_manuals", force: :cascade do |t|
    t.float "amount"
    t.bigint "eventuality_id", null: false
    t.string "title"
    t.boolean "charged", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["eventuality_id"], name: "index_eventuality_expense_manuals_on_eventuality_id"
  end

  create_table "eventuality_expenses", force: :cascade do |t|
    t.bigint "eventuality_id", null: false
    t.bigint "scale_id", null: false
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "charged", default: false
    t.index ["eventuality_id"], name: "index_eventuality_expenses_on_eventuality_id"
    t.index ["scale_id"], name: "index_eventuality_expenses_on_scale_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "municipalities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "title"
    t.string "capital"
    t.jsonb "parish"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_municipalities_on_state_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "active"
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_permissions_on_section_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title"
    t.float "coverage"
    t.float "payment_fee"
    t.jsonb "coverage_items"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "age_limit"
    t.boolean "own", default: false
    t.float "age_min", default: 0.0
    t.index ["product_id"], name: "index_plans_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "scales", force: :cascade do |t|
    t.string "title"
    t.float "amount"
    t.integer "category"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "pretty_name"
    t.integer "module_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "title"
    t.string "capital"
    t.jsonb "cities"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.string "agent_code"
    t.string "dni"
    t.string "mpps"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agreements", "customers"
  add_foreign_key "agreements", "users"
  add_foreign_key "coverage_items_plans", "coverage_items"
  add_foreign_key "coverage_items_plans", "plans"
  add_foreign_key "customer_diseases", "customers"
  add_foreign_key "customer_diseases", "diseases"
  add_foreign_key "customers", "customers", column: "parent_id"
  add_foreign_key "customers", "plans"
  add_foreign_key "eventualities", "agreements"
  add_foreign_key "eventualities", "customers"
  add_foreign_key "eventuality_expense_manuals", "eventualities"
  add_foreign_key "eventuality_expenses", "eventualities"
  add_foreign_key "eventuality_expenses", "scales"
  add_foreign_key "municipalities", "states"
  add_foreign_key "permissions", "sections"
  add_foreign_key "permissions", "users"
  add_foreign_key "plans", "products"
  add_foreign_key "products", "companies"
end
