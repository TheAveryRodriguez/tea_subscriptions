class AddSubscriptionsToTeaSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :tea_subscriptions, :subscription, null: false, foreign_key: true
  end
end
