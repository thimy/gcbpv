class AddSubscriptionAmount < ActiveRecord::Migration[7.1]
  def change
    add_column :subscription_groups, :amount, :decimal
    remove_reference :subscriptions, :season
  end
end
