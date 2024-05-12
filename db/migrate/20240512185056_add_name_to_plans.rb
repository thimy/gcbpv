class AddNameToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :name, :string
  end
end
