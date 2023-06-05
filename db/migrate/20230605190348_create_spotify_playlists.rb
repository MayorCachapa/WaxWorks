class CreateSpotifyPlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :spotify_playlists do |t|
      t.string :name
      t.references :spotify_track, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
