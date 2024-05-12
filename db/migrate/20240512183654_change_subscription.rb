class ChangeSubscription < ActiveRecord::Migration[7.1]
  def change
    remove_column :subscriptions, :year

    add_reference :subscriptions, :season
    add_column    :subscriptions, :status, :integer
  end
end
