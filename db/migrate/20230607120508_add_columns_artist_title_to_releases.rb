class AddColumnsArtistTitleToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :artist, :string
    add_column :releases, :title, :string
  end
end
