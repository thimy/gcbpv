class AddNewPricings < ActiveRecord::Migration[8.1]
  def change
    add_column :plans, :kid_workshop_price, :decimal
    add_column :plans, :kid_workshop_price_obc, :decimal
    add_column :plans, :kid_workshop_price_outbounds, :decimal
    add_column :plans, :class_double_workshop_price, :decimal
    add_column :plans, :class_double_workshop_price_obc, :decimal
    add_column :plans, :class_double_workshop_price_outbounds, :decimal
    add_column :plans, :kids_class_double_workshop_price, :decimal
    add_column :plans, :kids_class_double_workshop_price_obc, :decimal
    add_column :plans, :kids_class_double_workshop_price_outbounds, :decimal
    add_column :plans, :double_workshop_price, :decimal
    add_column :plans, :double_workshop_price_obc, :decimal
    add_column :plans, :double_workshop_price_outbounds, :decimal
    add_column :plans, :kid_double_workshop_price, :decimal
    add_column :plans, :kid_double_workshop_price_obc, :decimal
    add_column :plans, :kid_double_workshop_price_outbounds, :decimal
  end
end
