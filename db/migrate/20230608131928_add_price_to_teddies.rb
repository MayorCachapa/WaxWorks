class AddPriceToTeddies < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :price, :integer
    add_monetize :listings, :price, currency: { present: false }
  end
end
