class AddColumnFormatToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :format, :string
  end
end
