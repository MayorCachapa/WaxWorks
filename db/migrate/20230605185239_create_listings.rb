class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :condition
      t.string :sleeve_condition
      t.float :price
      t.float :shipping_fee
      t.text :comments
      t.boolean :allow_offers
      t.string :location
      t.boolean :availability

      t.timestamps
    end
  end
end
