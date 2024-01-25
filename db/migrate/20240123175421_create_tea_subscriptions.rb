class CreateTeaSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :tea_subscriptions do |t|
      t.timestamps
    end
  end
end
