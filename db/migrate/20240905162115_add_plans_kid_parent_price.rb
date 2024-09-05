class AddPlansKidParentPrice < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :parent_kid_price, :decimal
  end
end
