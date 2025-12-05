class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.string :instrument
      t.references :subscription, null: false, foreign_key: true
      t.decimal :cost
      t.text :comment

      t.timestamps
    end

    rename_column :subscriptions, :loan, :instrument_loan
  end
end
