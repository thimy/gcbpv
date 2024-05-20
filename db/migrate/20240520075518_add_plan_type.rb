class AddPlanType < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :early_learning_price, :decimal
    add_column :plans, :kid_discovery_price, :decimal
    add_column :plans, :adult_discovery_price, :decimal
    add_column :plans, :first_step_discount, :decimal
    add_column :plans, :first_step, :decimal
    add_column :plans, :second_step_discount, :decimal
    add_column :plans, :second_step, :decimal
    add_column :plans, :third_step_discount, :decimal
    add_column :plans, :third_step, :decimal
    add_column :plans, :fourth_step_discount, :decimal
    add_column :plans, :fourth_step, :decimal
  end
end
