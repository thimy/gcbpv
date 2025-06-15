class AddStandaloneWorkshopToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :standalone_workshop_price, :decimal
    add_column :subscription_groups, :discount, :decimal
  end
end
