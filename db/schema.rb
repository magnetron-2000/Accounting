# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_07_140538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill", id: :integer, default: nil, force: :cascade do |t|
    t.integer "bill_num"
    t.date "date_last_accrual_per"
    t.integer "balance_on_bill"
    t.date "date_creating_bill"
    t.integer "customer_id"
    t.integer "type_id"
    t.index ["bill_num"], name: "bill_num_index"
    t.index ["bill_num"], name: "un_bill_num", unique: true
    t.index ["customer_id"], name: "bill_customer_id_index"
    t.index ["type_id"], name: "type_id_index"
  end

  create_table "bill_type", id: :integer, default: nil, force: :cascade do |t|
    t.string "type_name", limit: 200
    t.integer "mounth_per_for_bill"
  end

  create_table "category", id: :integer, default: nil, force: :cascade do |t|
    t.string "category", limit: 200
    t.integer "add_per_for_category"
    t.index ["category"], name: "un_category", unique: true
  end

  create_table "customer", id: :integer, default: nil, force: :cascade do |t|
    t.string "first_name", limit: 200
    t.string "second_name", limit: 200
    t.integer "passport_number"
    t.string "passport_serial", limit: 200
    t.integer "mobile_number"
    t.string "address", limit: 200
    t.integer "category_id"
    t.index ["category_id"], name: "indexcategory_id"
    t.index ["mobile_number"], name: "unique_phone", unique: true
    t.index ["passport_number"], name: "unique_passport", unique: true
  end

  create_table "login", primary_key: "login", id: :string, limit: 200, force: :cascade do |t|
    t.integer "password"
    t.integer "customer_id"
    t.index ["customer_id"], name: "login_customer_id_index"
    t.index ["password"], name: "password_index"
    t.index ["password"], name: "un_password", unique: true
  end

  create_table "operation", id: :integer, default: nil, force: :cascade do |t|
    t.string "type_bank_operation", limit: 200
    t.integer "per_commission_for_operation"
    t.date "date_operation_about_bill"
    t.integer "sum_op_about_bill"
    t.integer "bill_id_source"
    t.integer "bill_id_destination"
  end

  add_foreign_key "bill", "bill_type", column: "type_id", name: "bill_type_id_fkey"
  add_foreign_key "bill", "customer", name: "bill_customer_id_fkey"
  add_foreign_key "customer", "category", name: "customer_category_id_fkey"
  add_foreign_key "login", "customer", name: "login_customer_id_fkey"
  add_foreign_key "operation", "bill", column: "bill_id_destination", name: "operation_bill_id_destination_fkey"
  add_foreign_key "operation", "bill", column: "bill_id_source", name: "operation_bill_id_source_fkey"
end
