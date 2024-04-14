class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.integer :year
      t.references :student, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :workshop, null: false, foreign_key: true
      t.integer :paid_amount
      t.references :payor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
