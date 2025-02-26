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

ActiveRecord::Schema[8.0].define(version: 2025_02_26_045158) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.text "address"
    t.string "city"
    t.string "pincode"
    t.bigint "state_id", null: false
    t.bigint "country_id", null: false
    t.integer "address_type"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "owner_name"
    t.string "phone_number"
    t.string "alternate_phone_number"
    t.string "email"
    t.string "gst_detail"
    t.string "pan_number"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_customers_on_organization_id"
  end

  create_table "hsns", force: :cascade do |t|
    t.string "schedule"
    t.string "s_no"
    t.text "code"
    t.string "description"
    t.string "chapter_heading"
    t.decimal "sgst"
    t.decimal "cgst"
    t.decimal "gst"
    t.decimal "cess"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_inventories", force: :cascade do |t|
    t.bigint "job_invoice_id", null: false
    t.bigint "product_id", null: false
    t.decimal "quantity"
    t.decimal "remaining_quantity", default: "0.0"
    t.decimal "unit_price"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_invoice_id"], name: "index_job_inventories_on_job_invoice_id"
    t.index ["product_id"], name: "index_job_inventories_on_product_id"
  end

  create_table "job_invoices", force: :cascade do |t|
    t.string "bill_no"
    t.date "date"
    t.bigint "customer_id", null: false
    t.decimal "total"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_job_invoices_on_customer_id"
    t.index ["organization_id"], name: "index_job_invoices_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "full_address"
    t.string "phone_number"
    t.string "gst_detail"
    t.string "bank_name"
    t.string "account_number"
    t.string "ifcs_code"
    t.string "branch"
    t.string "financial_year", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id", null: false
    t.bigint "state_id", null: false
    t.index ["country_id"], name: "index_organizations_on_country_id"
    t.index ["state_id"], name: "index_organizations_on_state_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "billable_type", null: false
    t.bigint "billable_id", null: false
    t.decimal "amount"
    t.date "date"
    t.string "payment_detail"
    t.integer "payment_mode", default: 0
    t.string "bill_no"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billable_type", "billable_id"], name: "index_payments_on_billable"
    t.index ["organization_id"], name: "index_payments_on_organization_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "barcode", default: ""
    t.string "description"
    t.bigint "hsn_id"
    t.decimal "price"
    t.decimal "quantity", default: "0.0"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hsn_id"], name: "index_products_on_hsn_id"
    t.index ["organization_id"], name: "index_products_on_organization_id"
  end

  create_table "purchase_inventories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "purchase_invoice_id", null: false
    t.decimal "price", default: "0.0"
    t.decimal "quantity", default: "0.0"
    t.decimal "remaining_quantity", default: "0.0"
    t.decimal "total", default: "0.0"
    t.decimal "cgst_percentage", default: "0.0"
    t.decimal "cgst", default: "0.0"
    t.decimal "sgst_percentage", default: "0.0"
    t.decimal "sgst", default: "0.0"
    t.decimal "discount_percentage", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.decimal "sub_total", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_inventories_on_product_id"
    t.index ["purchase_invoice_id"], name: "index_purchase_inventories_on_purchase_invoice_id"
  end

  create_table "purchase_invoices", force: :cascade do |t|
    t.string "bill_no"
    t.bigint "supplier_id", null: false
    t.date "date"
    t.decimal "total"
    t.decimal "cgst"
    t.decimal "sgst"
    t.decimal "discount"
    t.integer "payment_status", default: 0
    t.decimal "grand_total"
    t.decimal "paid_amount"
    t.text "billing_address"
    t.text "delivery_address"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_purchase_invoices_on_organization_id"
    t.index ["supplier_id"], name: "index_purchase_invoices_on_supplier_id"
  end

  create_table "purchase_return_inventories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "purchase_return_invoice_id"
    t.decimal "price", default: "0.0"
    t.decimal "quantity", default: "0.0"
    t.decimal "remaining_quantity", default: "0.0"
    t.decimal "total", default: "0.0"
    t.decimal "cgst_percentage", default: "0.0"
    t.decimal "cgst", default: "0.0"
    t.decimal "sgst_percentage", default: "0.0"
    t.decimal "sgst", default: "0.0"
    t.decimal "discount_percentage", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.decimal "sub_total", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_return_inventories_on_product_id"
    t.index ["purchase_return_invoice_id"], name: "idx_on_purchase_return_invoice_id_8aeb403d61"
  end

  create_table "purchase_return_invoices", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "purchase_invoice_id"
    t.bigint "supplier_id", null: false
    t.string "bill_no"
    t.date "date"
    t.decimal "total"
    t.decimal "cgst"
    t.decimal "sgst"
    t.decimal "discount"
    t.decimal "grand_total"
    t.decimal "received_amount", default: "0.0"
    t.integer "payment_status", default: 0
    t.text "billing_address"
    t.text "delivery_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_purchase_return_invoices_on_organization_id"
    t.index ["purchase_invoice_id"], name: "index_purchase_return_invoices_on_purchase_invoice_id"
    t.index ["supplier_id"], name: "index_purchase_return_invoices_on_supplier_id"
  end

  create_table "sales_inventories", force: :cascade do |t|
    t.bigint "sales_invoice_id", null: false
    t.bigint "product_id", null: false
    t.decimal "price", default: "0.0"
    t.decimal "quantity", default: "0.0"
    t.decimal "total", default: "0.0"
    t.decimal "cgst_percentage", default: "0.0"
    t.decimal "cgst", default: "0.0"
    t.decimal "sgst_percentage", default: "0.0"
    t.decimal "sgst", default: "0.0"
    t.decimal "discount_percentage", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.decimal "sub_total", default: "0.0"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoiceable_type"
    t.bigint "invoiceable_id"
    t.index ["invoiceable_type", "invoiceable_id"], name: "index_sales_inventories_on_invoiceable"
    t.index ["organization_id"], name: "index_sales_inventories_on_organization_id"
    t.index ["product_id"], name: "index_sales_inventories_on_product_id"
    t.index ["sales_invoice_id"], name: "index_sales_inventories_on_sales_invoice_id"
  end

  create_table "sales_invoices", force: :cascade do |t|
    t.string "bill_no"
    t.bigint "customer_id", null: false
    t.date "date"
    t.decimal "total"
    t.decimal "cgst"
    t.decimal "sgst"
    t.decimal "discount"
    t.decimal "grand_total"
    t.decimal "received_amount", default: "0.0"
    t.integer "payment_status", default: 0
    t.text "billing_address", default: ""
    t.text "delivery_address", default: ""
    t.string "gst_code"
    t.integer "bill_type", default: 0
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sales_invoices_on_customer_id"
    t.index ["organization_id"], name: "index_sales_invoices_on_organization_id"
  end

  create_table "sales_return_inventories", force: :cascade do |t|
    t.bigint "sales_return_invoice_id"
    t.bigint "product_id", null: false
    t.decimal "price", default: "0.0"
    t.decimal "quantity", default: "0.0"
    t.decimal "total", default: "0.0"
    t.decimal "cgst_percentage", default: "0.0"
    t.decimal "cgst", default: "0.0"
    t.decimal "sgst_percentage", default: "0.0"
    t.decimal "sgst", default: "0.0"
    t.decimal "discount_percentage", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.decimal "sub_total", default: "0.0"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoiceable_type"
    t.bigint "invoiceable_id"
    t.index ["invoiceable_type", "invoiceable_id"], name: "index_sales_return_inventories_on_invoiceable"
    t.index ["organization_id"], name: "index_sales_return_inventories_on_organization_id"
    t.index ["product_id"], name: "index_sales_return_inventories_on_product_id"
    t.index ["sales_return_invoice_id"], name: "index_sales_return_inventories_on_sales_return_invoice_id"
  end

  create_table "sales_return_invoices", force: :cascade do |t|
    t.string "bill_no"
    t.bigint "customer_id", null: false
    t.date "date"
    t.decimal "total"
    t.decimal "cgst"
    t.decimal "sgst"
    t.decimal "discount"
    t.decimal "grand_total"
    t.decimal "paid_amount", default: "0.0"
    t.integer "payment_status", default: 0
    t.text "billing_address", default: ""
    t.text "delivery_address", default: ""
    t.string "gst_code"
    t.integer "bill_type", default: 0
    t.bigint "organization_id"
    t.bigint "sales_invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sales_return_invoices_on_customer_id"
    t.index ["organization_id"], name: "index_sales_return_invoices_on_organization_id"
    t.index ["sales_invoice_id"], name: "index_sales_return_invoices_on_sales_invoice_id"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
    t.string "code"
    t.string "gst_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "owner_name"
    t.string "phone_number"
    t.string "alternate_phone_number"
    t.string "email"
    t.string "gst_detail"
    t.string "pan_number"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_suppliers_on_organization_id"
  end

  create_table "user_organizations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_user_organizations_on_organization_id"
    t.index ["user_id"], name: "index_user_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.string "name"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
end
