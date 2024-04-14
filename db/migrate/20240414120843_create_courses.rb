class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.references :slot, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
