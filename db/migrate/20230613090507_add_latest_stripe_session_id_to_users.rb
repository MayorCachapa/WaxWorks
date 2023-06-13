class AddLatestStripeSessionIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lastest_strip_session_id, :string
  end
end
