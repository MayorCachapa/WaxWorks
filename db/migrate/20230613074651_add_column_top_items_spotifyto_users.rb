class AddColumnTopItemsSpotifytoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :top_albums, :text, default: [], array: true
    add_column :users, :top_artists, :text, default: [], array: true
    add_column :users, :saved_albums, :text, default: [], array: true
  end
end
