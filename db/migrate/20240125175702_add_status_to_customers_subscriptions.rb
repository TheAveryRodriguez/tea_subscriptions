class AddStatusToCustomersSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :customers_subscriptions, :status, :integer, default: 0
  end
end
