class AddLatestStripeSessionIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lastest_stripe_session_id, :string
  end
end
