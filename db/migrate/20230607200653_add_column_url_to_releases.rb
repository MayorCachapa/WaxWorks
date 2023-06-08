class AddColumnUrlToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :url, :string
  end
end
