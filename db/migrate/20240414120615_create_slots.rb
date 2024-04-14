class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.integer :day_of_week
      t.string :start_time
      t.string :end_time
      t.integer :frequency

      t.timestamps
    end
  end
end
