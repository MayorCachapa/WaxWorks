class AddDefaultToFavorites < ActiveRecord::Migration[7.0]
  def change
    change_column :favorites, :alert, :boolean, default: true
  end
end
