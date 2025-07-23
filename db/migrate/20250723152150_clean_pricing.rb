class CleanPricing < ActiveRecord::Migration[7.1]
  def change
    remove_column :plans, :pathway_price
    remove_column :workshops, :workshop_type
  end
end
