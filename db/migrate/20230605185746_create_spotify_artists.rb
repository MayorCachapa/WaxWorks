class CreateSpotifyArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :spotify_artists do |t|
      t.string :name
      t.string :genre
      t.integer :popularity

      t.timestamps
    end
  end
end
