class RemoveSpotifyTopItemTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :spotify_top_items
  end
end
