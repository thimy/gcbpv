class CreateSubscriptionGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :subscription_groups do |t|
      t.decimal :amount_paid
      t.text :comment
      t.references :payor, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true
      t.decimal :donation

      t.timestamps
    end

    create_table :payments do |t|
      t.integer :payment_method
      t.decimal :amount
      t.references :subscription_group, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end

    add_reference :subscriptions, :subscription_group
  end
end
