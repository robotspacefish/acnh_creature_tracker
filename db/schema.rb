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

ActiveRecord::Schema.define(version: 2020_04_14_180405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availables", force: :cascade do |t|
    t.string "time"
    t.integer "start_time"
    t.integer "end_time"
  end

  create_table "availables_creatures", id: false, force: :cascade do |t|
    t.bigint "available_id", null: false
    t.bigint "creature_id", null: false
  end

  create_table "creatures", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "image_url"
    t.string "c_type"
    t.string "shadow_size"
    t.string "price"
    t.string "location"
  end

  create_table "creatures_users", id: false, force: :cascade do |t|
    t.bigint "creature_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "hemispheres", force: :cascade do |t|
    t.string "h_type"
    t.boolean "january"
    t.boolean "february"
    t.boolean "march"
    t.boolean "april"
    t.boolean "may"
    t.boolean "june"
    t.boolean "july"
    t.boolean "august"
    t.boolean "september"
    t.boolean "october"
    t.boolean "november"
    t.boolean "december"
    t.bigint "creature_id"
    t.index ["creature_id"], name: "index_hemispheres_on_creature_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "hemisphere"
  end

end
