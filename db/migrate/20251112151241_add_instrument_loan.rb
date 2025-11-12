class AddInstrumentLoan < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :loan, :string
  end
end
