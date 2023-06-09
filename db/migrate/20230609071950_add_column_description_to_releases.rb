class AddColumnDescriptionToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :description, :text
  end
end
