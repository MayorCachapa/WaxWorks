class CreateUserTopSpotifyItems < ActiveRecord::Migration[7.0]
  def change
    create_table :user_top_spotify_items do |t|
      t.references :spotify_track, null: false, foreign_key: true
      t.references :spotify_artist, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
