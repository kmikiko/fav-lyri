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

ActiveRecord::Schema.define(version: 2023_07_19_125641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "lyric_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lyric_id"], name: "index_artists_on_lyric_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lyric_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lyric_id"], name: "index_favorites_on_lyric_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feelings", force: :cascade do |t|
    t.string "sort"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lyrics", force: :cascade do |t|
    t.string "phrase", null: false
    t.string "detail", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_lyrics_on_user_id"
  end

  create_table "lyrics_feelings", force: :cascade do |t|
    t.bigint "lyric_id", null: false
    t.bigint "feeling_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feeling_id"], name: "index_lyrics_feelings_on_feeling_id"
    t.index ["lyric_id"], name: "index_lyrics_feelings_on_lyric_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "lyric_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lyric_id"], name: "index_songs_on_lyric_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "name", default: "名前未登録", null: false
    t.text "icon"
    t.string "image_cache"
    t.text "introduction"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "artists", "lyrics"
  add_foreign_key "favorites", "lyrics"
  add_foreign_key "favorites", "users"
  add_foreign_key "lyrics", "users"
  add_foreign_key "lyrics_feelings", "feelings"
  add_foreign_key "lyrics_feelings", "lyrics"
  add_foreign_key "songs", "lyrics"
  add_foreign_key "user_profiles", "users"
end
