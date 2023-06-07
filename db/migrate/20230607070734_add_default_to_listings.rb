class AddDefaultToListings < ActiveRecord::Migration[7.0]
  def change
    change_column :listings, :availability, :boolean, default: true
    change_column :listings, :allow_offers, :boolean, default: true
  end
end
