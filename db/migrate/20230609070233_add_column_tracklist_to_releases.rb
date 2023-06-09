class AddColumnTracklistToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :tracklist, :text, default: [], array: true
  end
end
