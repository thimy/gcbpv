class ReworkPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :price_categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :plan_price_categories do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :price_category, null: false, foreign_key: true
      t.decimal :price
      t.decimal :obc_price
      t.decimal :outbounds_price

      t.timestamps
    end

    add_column :plans, :class_price_obc, :decimal
    add_column :plans, :class_price_outbounds, :decimal
    add_column :plans, :kids_class_price_obc, :decimal
    add_column :plans, :kids_class_price_outbounds, :decimal
    add_column :plans, :workshop_price_obc, :decimal
    add_column :plans, :workshop_price_outbounds, :decimal
    add_column :plans, :early_learning_price_obc, :decimal
    add_column :plans, :early_learning_price_outbounds, :decimal
    add_column :plans, :kid_discovery_price_obc, :decimal
    add_column :plans, :kid_discovery_price_outbounds, :decimal
    add_column :workshops, :is_full, :boolean
    add_reference :workshops, :price_category
    remove_column :plans, :family_pathway_price, :decimal
    remove_column :plans, :special_workshop_price, :decimal
    remove_column :plans, :parent_kid_price, :decimal
    remove_column :plans, :standalone_workshop_price, :decimal
  end
end
