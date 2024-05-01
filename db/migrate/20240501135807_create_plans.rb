class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.decimal :class_price
      t.decimal :kids_class_price
      t.decimal :workshop_price
      t.integer :obc_markup
      t.integer :outbounds_markup

      t.timestamps
    end
  end
end
