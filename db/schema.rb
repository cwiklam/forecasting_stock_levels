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

ActiveRecord::Schema[7.0].define(version: 2022_05_15_121505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.string "order_number", null: false
    t.integer "price", null: false
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_orders", force: :cascade do |t|
    t.bigint "products_id"
    t.bigint "orders_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orders_id"], name: "index_product_orders_on_orders_id"
    t.index ["products_id"], name: "index_product_orders_on_products_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.integer "price", null: false
    t.integer "availability", null: false
    t.integer "max", null: false
    t.jsonb "atts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
