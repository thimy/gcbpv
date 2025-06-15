class AddPathwayPriceToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :family_pathway_price, :decimal
  end
end
