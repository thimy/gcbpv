class CreateWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :description
      t.references :city, null: false, foreign_key: true
      t.integer :day_of_week
      t.integer :frequency
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
