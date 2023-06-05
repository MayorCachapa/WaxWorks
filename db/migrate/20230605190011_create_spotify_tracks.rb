class CreateSpotifyTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :spotify_tracks do |t|
      t.string :name
      t.float :duration_ms
      t.references :spotify_album, null: false, foreign_key: true
      t.references :spotify_artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
