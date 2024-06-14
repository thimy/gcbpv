class SubscriptionPayor < ActiveRecord::Migration[7.1]
  def change
    remove_reference :subscriptions, :payor
  end
end
