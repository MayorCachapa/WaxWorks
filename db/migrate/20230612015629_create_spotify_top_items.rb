class CreateSpotifyTopItems < ActiveRecord::Migration[7.0]
  def change
    create_table :spotify_top_items do |t|
      t.text :top_artists, default: [], array: true
      t.text :top_tracks_albums, default: [], array: true
      t.text :saved_albums, default: [], array: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
