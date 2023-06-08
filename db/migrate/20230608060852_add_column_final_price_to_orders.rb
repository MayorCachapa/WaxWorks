class AddColumnFinalPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :final_price, :float
  end
end
