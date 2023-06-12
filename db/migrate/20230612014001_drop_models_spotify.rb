class DropModelsSpotify < ActiveRecord::Migration[7.0]
  def change
    drop_table :spotify_albums, force: :cascade
    drop_table :spotify_artists, force: :cascade
    drop_table :spotify_playlists, force: :cascade
    drop_table :spotify_tracks, force: :cascade
    drop_table :user_top_spotify_items, force: :cascade
  end
end
