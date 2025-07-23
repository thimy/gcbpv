class AddPaymentDate < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :date, :datetime
  end
end
