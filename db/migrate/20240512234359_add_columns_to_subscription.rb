class AddColumnsToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :image_consent, :boolean
    add_column :subscriptions, :disability, :boolean
    add_column :subscriptions, :ars, :boolean
    add_column :subscriptions, :donation, :decimal
  end
end
