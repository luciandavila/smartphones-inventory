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

ActiveRecord::Schema.define(version: 2020_11_05_015139) do

  create_table "smartphones", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "color"
    t.string "carrier_plan_type"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_plan_type"], name: "index_smartphones_on_carrier_plan_type"
    t.index ["manufacturer"], name: "index_smartphones_on_manufacturer"
    t.index ["model"], name: "index_smartphones_on_model"
  end

end
