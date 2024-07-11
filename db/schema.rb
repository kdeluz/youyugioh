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

ActiveRecord::Schema[7.1].define(version: 2024_07_11_171124) do
  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "fname"
    t.string "card_id"
    t.string "konami_id"
    t.string "card_type"
    t.integer "atk"
    t.integer "def"
    t.integer "level"
    t.string "race"
    t.string "card_attribute"
    t.string "linkmarker"
    t.integer "scale"
    t.string "cardset"
    t.string "archetype"
    t.string "banlist"
    t.string "format"
    t.boolean "staple"
    t.boolean "has_effect"
    t.date "startdate"
    t.date "enddate"
    t.string "dateregion"
    t.text "description"
    t.string "image_url"
    t.decimal "price", precision: 8, scale: 2
    t.boolean "sale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "address_line1"
    t.string "address_line2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
