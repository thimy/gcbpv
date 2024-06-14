class Payor < ActiveRecord::Migration[7.1]
  def change
    add_column :payors, :address, :string
    add_column :payors, :postcode, :string
    add_column :payors, :city, :string
  end
end
