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

ActiveRecord::Schema[7.0].define(version: 2023_06_05_191839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "condition"
    t.string "sleeve_condition"
    t.float "price"
    t.float "shipping_fee"
    t.text "comments"
    t.boolean "allow_offers"
    t.string "location"
    t.boolean "availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "spotify_albums", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.string "image_url"
    t.integer "popularity"
    t.bigint "spotify_artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_artist_id"], name: "index_spotify_albums_on_spotify_artist_id"
  end

  create_table "spotify_artists", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spotify_playlists", force: :cascade do |t|
    t.string "name"
    t.bigint "spotify_track_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_track_id"], name: "index_spotify_playlists_on_spotify_track_id"
    t.index ["user_id"], name: "index_spotify_playlists_on_user_id"
  end

  create_table "spotify_tracks", force: :cascade do |t|
    t.string "name"
    t.float "duration_ms"
    t.bigint "spotify_album_id", null: false
    t.bigint "spotify_artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_album_id"], name: "index_spotify_tracks_on_spotify_album_id"
    t.index ["spotify_artist_id"], name: "index_spotify_tracks_on_spotify_artist_id"
  end

  create_table "user_top_spotify_items", force: :cascade do |t|
    t.bigint "spotify_track_id", null: false
    t.bigint "spotify_artist_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_artist_id"], name: "index_user_top_spotify_items_on_spotify_artist_id"
    t.index ["spotify_track_id"], name: "index_user_top_spotify_items_on_spotify_track_id"
    t.index ["user_id"], name: "index_user_top_spotify_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "listings", "users"
  add_foreign_key "spotify_albums", "spotify_artists"
  add_foreign_key "spotify_playlists", "spotify_tracks"
  add_foreign_key "spotify_playlists", "users"
  add_foreign_key "spotify_tracks", "spotify_albums"
  add_foreign_key "spotify_tracks", "spotify_artists"
  add_foreign_key "user_top_spotify_items", "spotify_artists"
  add_foreign_key "user_top_spotify_items", "spotify_tracks"
  add_foreign_key "user_top_spotify_items", "users"
end
