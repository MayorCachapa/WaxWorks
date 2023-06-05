class CreateSpotifyAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :spotify_albums do |t|
      t.string :name
      t.string :label
      t.string :image_url
      t.integer :popularity
      t.references :spotify_artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
