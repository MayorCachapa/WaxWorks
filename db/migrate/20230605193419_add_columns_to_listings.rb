class AddColumnsToListings < ActiveRecord::Migration[7.0]
  def change
    add_reference :listings, :release, null: false, foreign_key: true
  end
end
