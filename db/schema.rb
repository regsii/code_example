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

ActiveRecord::Schema[7.0].define(version: 2023_01_28_221658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.decimal "points_qual", precision: 6, scale: 5
    t.integer "prize_pool_cents"
    t.integer "buy_in_cents"
    t.integer "entrants_count"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tournaments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.integer "place"
    t.integer "points"
    t.integer "prize_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id", "user_id"], name: "index_user_tournaments_on_tournament_id_and_user_id"
    t.index ["tournament_id"], name: "index_user_tournaments_on_tournament_id"
    t.index ["user_id", "tournament_id"], name: "index_user_tournaments_on_user_id_and_tournament_id"
    t.index ["user_id"], name: "index_user_tournaments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_tournaments", "tournaments"
  add_foreign_key "user_tournaments", "users"
end
